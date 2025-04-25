module Api
  module V1
    class CartItemsController < ApplicationController
      before_action :set_cart

      def index
        render json: @cart.cart_items.includes(:product)
      end

      def create
        cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
        cart_item.quantity += (params[:quantity] || 1).to_i

        if cart_item.save
          render json: cart_item, status: :created
        else
          render json: { error: cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        cart_item = @cart.cart_items.find(params[:id])
        if cart_item.update(quantity: params[:quantity])
          render json: cart_item
        else
          render json: { error: cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        cart_item = @cart.cart_items.find(params[:id])
        cart_item.destroy
        render json: {message: "cart item deleted "} 
      end

      private
      def set_cart
        @cart = current_user.cart || current_user.create_cart
      end
    end
  end
end
