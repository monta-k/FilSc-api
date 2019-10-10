module Api
  module V1
    class SigninController < ApplicationController
      def create
        if decoded_token = authenticate_firebase_id_token
          unless @user = User.find_by(uid: decoded_token[:user_id])
            @user = User.create(
              name: params[:name] || decoded_token[:name],
              uid: decoded_token[:user_id],
              email: decoded_token[:email]
            )
          end
          render 'create', formats: 'json', handlers: 'jbuilder'
        else
          render json: { message: 'signin error' }, status: :unprocessable_entity
        end
      end
    end
  end
end
