module Api::V1
  class OrdersController < ApplicationController
    def index
      @orders = @current_user.orders.includes(:order_items)
      render json: @orders, include: :order_items
    end

    def create
      @order = @current_user.orders.new(order_params)
      

      if @order.save
        OrderConfirmationWorker.perform_async(@order.id)
        render json: @order, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end      
    end

    private

    def order_params
      params.require(:order).permit(order_items_attributes: [:product_id, :quantity, :price])
    end

   
  end
end
