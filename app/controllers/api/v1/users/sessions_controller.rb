class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_action :verify_authenticity_token

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: {
        code: 200,
        message: 'Logged in successfully.',
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: 'No active session found.'
      }, status: :unauthorized
    end
  end
end
