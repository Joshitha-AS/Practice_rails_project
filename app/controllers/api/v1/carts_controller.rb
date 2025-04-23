module Api
  module V1
    class CartsController < ApplicationController
      before_action :authenticate_user!

      def show
        cart = current_user.cart || current_user.create_cart
        render json: { cart: cart }, status: :ok
      end

      def create
        cart = current_user.create_cart
        render json: { cart: cart }, status: :created
      end

      def update
        cart = current_user.cart
        if cart.update(cart_params)
          render json: { cart: cart }, status: :ok
        else
          render json: { errors: cart.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        cart = current_user.cart
        if cart
          cart.destroy
          head :no_content
        else
          render json: { error: 'Cart not found' }, status: :not_found
        end
      end

      private

      def cart_params
        params.require(:cart).permit(:any_cart_attributes) # Add permitted attributes here if needed
      end
    end
  end
end
