module Api
  module V1
    class PopularMoviesController < ApplicationController
      def show
        @popular_movies = PopularMovie.order('RANDOM()').limit(20)
        @movies = @popular_movies.map(&:tmdb_movie)
        render json: @movies, Serializer: TmdbMovieSerializer
      end
    end
  end
end
