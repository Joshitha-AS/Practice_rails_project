module Api
  module V1
    class CartsController < ApplicationController
      def show
        cart = current_user.cart
        render json: { cart: cart }, status: :ok
      end

      def create
        cart = current_user.cart || current_user.create_cart!
        render json: { cart: cart, message: "The cart created succesfullly" }, status: :created
      end

      def update
        cart = current_user.cart
        if cart.update(cart_params)
          render json: { cart: cart, message: "Cart updated succesfully" }, status: :ok
        else
          render json: { errors: cart.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        cart = current_user.cart
        if cart
          cart.destroy
          render json: {message: "cart deleted sucessfully"}
        else
          render json: { error: "Cart not found" }, status: :not_found
        end
      end

      private

      def cart_params
        params.require(:cart).permit(:any_cart_attributes) 
      end
    end
  end
end
