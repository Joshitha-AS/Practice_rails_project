class ApplicationController < ActionController::API 
  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    header = request.headers["Authorization"]
    unless header
      render json: { error: "Unauthorized" }, status: :unauthorized and return
    end
    token = header.split.last if header
    decoded = JsonWebToken.decode(token)
    unless decoded
      render json: { error: "Unauthorized" }, status: :unauthorized and return
    end
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: "Unauthorized" }, status: :unauthorized and return
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: "Record not found" }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: "Missing parameter: #{exception.param}" }, status: :bad_request
  end
end
