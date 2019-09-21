require 'json'
require 'net/https'
require 'uri'

module Batch::PopularMovies extend self
  def batch
    reset_db

    15.times do |i|
      uri = URI("https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API_KEY']}&language=ja&page=#{i + 1}&region=JP")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(uri)
      res = http.request(req)
      res_body = JSON.parse(res.body)
      res_body['results'].each do |movie|
        save(movie)
      end
    end
  end

  def reset_db
    PopularMovie.all.each do |movie|
      movie.destroy
    end
  end

  def save(movie)
    if TmdbMovie.find_by_id(movie['id']).nil?
      TmdbMovie.create(
        id: movie['id'],
        title: movie['title'],
        image: "https://image.tmdb.org/t/p/w1280#{movie['poster_path']}"
      )
    end
    PopularMovie.create(tmdb_movie_id: movie['id'])
  end
end