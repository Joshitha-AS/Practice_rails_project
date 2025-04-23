class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!

  puts "Current user is: #{current_user.inspect}"


  def index
    orders = current_user.orders
    render json: orders
  end
end
