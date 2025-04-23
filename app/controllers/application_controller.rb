class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  allow_browser versions: :modern
end
