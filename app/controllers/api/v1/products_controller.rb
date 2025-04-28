module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      def index
        products = Product.all
        render json: products
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: { message: "Product created successfully" }, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: @product.as_json(
          only:[:name,:price]
        )
      end

      def update
        if @product.update(product_params)
          Rails.cache.delete(cache_key(@product.id))
          render json: @product
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        Rails.cache.delete(cache_key(@product.id))
        @product.destroy
        head :no_content
      end

      private

      def set_product
        product_id = params[:id]
        @product = Rails.cache.fetch(cache_key(product_id), expires_in: 5.minutes) do
          Product.find(product_id)
        end
      end

      def cache_key(product_id)
        "product/#{product_id}"
      end

      def product_params
        params.require(:product).permit(:name, :price)
      end
    end
  end
end
