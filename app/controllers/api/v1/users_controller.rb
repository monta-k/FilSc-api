module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate
      def update
        @user = current_user
        if @user.update(user_params)
          render 'update', formats: 'json', handlers: 'jbuilder'
        else
          render json: { message: 'some error' }, status: :unprocessable_entity
        end
      end

      def destroy
        @user = current_user
        if @user.destroy
          head :no_content
        else
          render json: { message: 'some error' }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:filmarks_id, :name)
      end
    end
  end
end
