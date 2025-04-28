module Api::V1
  class OrdersController < ApplicationController
    def index
      cache_key = "user_#{@current_user.id}_orders_json"

      orders_json = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
        puts "====> CACHE MISS: Generating fresh orders JSON <====="

        orders = @current_user.orders.includes(:order_items)
        orders.as_json(include: :order_items).to_json
      end

      render json: orders_json
    end

    def create
      @order = @current_user.orders.new(order_params)
      if @order.save!
        Rails.cache.delete("user_#{@current_user.id}_orders_json") # Clear JSON cache
        OrderConfirmationWorker.perform_async(@order.id)
        render json: @order, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end
    
    
    private
    def order_params
      params.require(:order).permit(order_items_attributes: [:product_id, :price, :quantity])
    end
  end
end
