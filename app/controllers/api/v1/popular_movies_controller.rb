module Api
  module V1
    class PopularMoviesController < ApplicationController
      def show
        @movies = PopularMovie.order('RANDOM()').limit(20)
        render 'show', formats: 'json', handlers: 'jbuilder'
      end
    end
  end
end
