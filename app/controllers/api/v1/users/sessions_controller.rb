module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        # Called on successful login
        def respond_with(resource, _opts = {})
          render json: {
            message: "Login successful",
            user: resource
          }, status: :ok
        end

        # Called on logout
        def respond_to_on_destroy
          if current_user
            render json: { message: "Logout successful" }, status: :ok
          else
            render json: { message: "User already logged out or not found" }, status: :unauthorized
          end
        end
      end
    end
  end
end
