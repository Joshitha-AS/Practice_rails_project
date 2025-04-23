module Api
  module V1
    class UsersController < ApplicationController
      # GET /api/v1/users
      def index
        users = User.all
        render json: users
      end

      # GET /api/v1/users/:id
      def show
        user = User.find(params[:id])
        render json: user
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      # POST /api/v1/users (sign up)
      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
