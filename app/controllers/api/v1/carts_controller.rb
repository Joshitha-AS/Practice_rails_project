module Api
  module V1
    class CartsController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: { cart: current_user.cart }
      end

      def create
        cart = current_user.create_cart
        render json: cart, status: :created
      end

      def update
        cart = current_user.cart
        cart.update(cart_params)
        render json: cart
      end

      def destroy
        cart = current_user.cart
        cart.destroy
        head :no_content
      end

      private

      def cart_params
        params.require(:cart).permit()
      end
    end
  end
end
