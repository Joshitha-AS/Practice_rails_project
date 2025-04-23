module Api
  module V1
    class ProductsController < ApplicationController
      # GET /api/v1/products
      def index
        products = Product.all
        render json: products
      end

      # GET /api/v1/products/:id
      def show
        product = Product.find(params[:id])
        render json: product
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Product not found" }, status: :not_found
      end
    end
  end
end

