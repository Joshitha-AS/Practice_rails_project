module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        skip_before_action :verify_authenticity_token

        def create
          user = User.find_by(email: params[:user][:email])

          if user && user.valid_password?(params[:user][:password])
            sign_in(user)
            render json: {
              message: "Login successful",
              user: user
            }, status: :ok
          else
            render json: {
              error: "Invalid email or password"
            }, status: :unauthorized
          end
        end

        def destroy
          sign_out(current_user)
          render json: { message: "Logout successful" }, status: :ok
        end
      end
    end
  end
end
