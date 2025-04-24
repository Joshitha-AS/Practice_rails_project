module Api::V1
  class OrderItemsController < ApplicationController
    before_action :set_order

    def index
      @order_items = @order.order_items
      render json: @order_items
    end

    def show
      @order_item = @order.order_items.find(params[:id])
      render json: @order_item
    end

    private

    def set_order
      @order = current_user.orders.find(params[:order_id])
    end
  end
end
