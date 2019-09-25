module Api
  module V1
    class SigninController < ApplicationController
      def create
        if decoded_token = authenticate_firebase_id_token
          unless @user = User.find_by(uid: decoded_token['uid'])
            @user = User.create(
              name: params[:name] || decoded_token['decode_token'][:payload]['name'],
              uid: decoded_token['uid'],
              email: decoded_token['decode_token'][:payload]['email']
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
