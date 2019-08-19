module Api
  module V1
    class HomesController < ApplicationController
      def index
        data = FilScrape.scrape
        title = data[:title]
        movie = data[:movie].sort_by { |m| m[1] }
        render json: {title: title, movie: movie}
      end
    end
  end
end