class ApplicationController < ActionController::API 

  include ActionController::MimeResponds
  include ActionController::Cookies

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    unless header
      render json: { error: 'Unauthorized' }, status: :unauthorized and return
    end
    token = header.split.last if header
    decoded = JsonWebToken.decode(token)
    unless decoded
      render json: { error: 'Unauthorized' }, status: :unauthorized and return
    end
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized and return
  end
  
end