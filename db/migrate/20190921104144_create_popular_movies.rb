class CreatePopularMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :popular_movies do |t|
      t.integer :tmdb_movie_id, foreign_key: true

      t.timestamps
    end
  end
end
