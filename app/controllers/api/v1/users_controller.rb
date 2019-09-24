module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate
      def update
        if @current_user.update(user_params)
          render 'update', formats: 'json', handlers: 'jbuilder'
        else
          render json: { message: 'some error' }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:filmarks_id)
      end
    end
  end
end