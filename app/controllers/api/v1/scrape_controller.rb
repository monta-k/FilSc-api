module Api
  module V1
    class ScrapeController < ApplicationController
      before_action :authenticate

      def find_user
        data = FilScrape.find_user(params[:searchId])
        render json: data
      end

      def clip_movies_page
        data = FilScrape.clip_movies_page(params[:userId])
        render json: data
      end
    end
  end
end