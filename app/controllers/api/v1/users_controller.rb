module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: users
      end
      def show
        user = User.find(params[:id])
        render json: UserSerializer.neew(user).serilizable_hash
      end
    end
  end
end