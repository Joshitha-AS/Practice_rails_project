module Api::V1
  class OrderItemsController < ApplicationController
    before_action :set_order
    def show
      @order_item = @order.order_items.find(params[:id])
      render json: @order_item
    end

    def update
      if @order_item.update(order_item_params)
        render json: @order_item, status: :ok
      else
        render json: { errors: @order_item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @order_item.destroy
      head :no_content
    end

    private
    def set_order
      @order = current_user.orders.find(params[:order_id])
    end
  end
end
