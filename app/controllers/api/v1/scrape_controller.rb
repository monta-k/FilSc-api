module Api
  module V1
    class ScrapeController < ApplicationController
      before_action :authenticate

      def find_user
        @data = FilScrape.find_user(params[:searchId])
        render json: @data, status: :ok
      end

      def clip_movies_page
        @data = FilScrape.clip_movies_page(params[:userId])
        render json: @data, status: :ok
      end

      def clip_movies
        @data = FilScrape.clip_movies(params[:userId], params[:page])
        render json: @data, status: :ok
      end
    end
  end
end
