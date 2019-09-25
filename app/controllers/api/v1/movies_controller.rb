module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate

      def show
        @movies = current_user.movies.order(length: :asc)
        render 'show', formats: 'json', handlers: 'jbuilder'
      end

      def create
        new_movies = params[:movies]
        new_movies.each do |movie|
          current_user.movies.create!(title: movie[:title], length: movie[:length], score: movie[:score], image: movie[:image], link: movie[:link])
        end
        @movies = current_user.movies.order(length: :asc)
        render 'create', formats: 'json', handlers: 'jbuilder'
      end

      def destroy
        movies = current_user.movies
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