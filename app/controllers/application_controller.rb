class ApplicationController < ActionController::API
  before_action :authorize_request
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  attr_reader :current_user

  private
  def authorize_request
    header = request.headers["Authorization"]
    return unauthorized unless header

    token = header.split.last
    decoded = JsonWebToken.decode(token)
    return unauthorized unless decoded

    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    unauthorized
  end

  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end


  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def record_invalid(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def parameter_missing(exception)
    render json: { error: "Missing parameter: #{exception.param}" }, status: :bad_request
  end
end
