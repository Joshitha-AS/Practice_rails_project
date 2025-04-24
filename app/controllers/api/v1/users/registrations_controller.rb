
class Api::V1::Users::RegistrationsController < ApplicationController
  skip_before_action :authorize_request, only: [:register]

  def register
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def serialize_user(user)
    user.as_json(only: [:id, :name, :email])
  end
end
