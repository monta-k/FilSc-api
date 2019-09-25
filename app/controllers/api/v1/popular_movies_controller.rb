module Api
  module V1
    class PopularMoviesController < ApplicationController
      def show
        popular_movies = PopularMovie.order('RANDOM()').limit(20)
        @movies = popular_movies.map do |m|
          TmdbMovie.find(m.tmdb_movie_id)
        end
        render 'show', formats: 'json', handlers: 'jbuilder'
      end
    end
  end
end
