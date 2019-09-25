module Api
  module V1
    class ScrapeController < ApplicationController
      before_action :authenticate

      def find_user
        @data = FilScrape.find_user(params[:searchId])
        render 'find_user', formats: 'json', handlers: 'jbuilder'
      end

      def clip_movies_page
        @data = FilScrape.clip_movies_page(params[:userId])
        render 'clip_movies_page', formats: 'json', handlers: 'jbuilder'
      end

      def clip_movies
        @data = FilScrape.clip_movies(params[:userId], params[:page])
        render 'clip_movies', formats: 'json', handlers: 'jbuilder'
      end
    end
  end
end
