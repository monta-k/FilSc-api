module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate

      def create
        new_movies = params[:movies]
        movies = new_movies.map do |movie|
          @current_user.movies.create!(title: movie[:title], length: movie[:length], score: movie[:score], image: movie[:image], link: movie[:link])
        end
        render json: movies
      end

      def destroy
        movies = @current_user.movies
        unless movies.empty?
          movies.each do |movie|
            movie.destroy!
          end
        end
        head :no_content
      end
    end
  end
end