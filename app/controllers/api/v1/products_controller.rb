module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [ :show, :update, :destroy ]

      # GET /api/v1/products
      def index
        products = Product.all
        render json: products
      end

      def create
        product=Product.new(product_params)
        if product.save
          render json: { message: "product created successfully" }, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/products/:id
      def show
        render json: @product
      end

      # PATCH/PUT /api/v1/products/:id
      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/products/:id
      def destroy
        if @product.destroy
          render json: { message: "Deleted successfully" }, status: :ok
        else
          render json: { error: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end


      private
      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :price)
      end
    end
  end
end
