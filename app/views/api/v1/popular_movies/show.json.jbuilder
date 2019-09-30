json.array! @movies do |movie|
  json.title movie.tmdb_movie.title
  json.image movie.tmdb_movie.image
  json.homepage movie.tmdb_movie.homepage
  json.created_at movie.tmdb_movie.created_at
  json.updated_at movie.tmdb_movie.updated_at
end
