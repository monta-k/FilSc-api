class CreateUserRecommendedMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_recommended_movies do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tmdb_movie, index: true, foreign_key: true

      t.timestamps
    end
  end
end
