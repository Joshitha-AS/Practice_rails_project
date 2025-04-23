module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        def create
          build_resource(sign_up_params)

          resource.save
          if resource.persisted?
            render json: {
              message: "Sign up successful",
              user: resource
            }, status: :created
          else
            render json: {
              errors: resource.errors.full_messages
            }, status: :unprocessable_entity
          end
        end

        private

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
