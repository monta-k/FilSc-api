namespace :batch do
  desc "popular moviesを取得"
  task popular_movies: :environment do
    Batch::PopularMovies.batch
  end
end
