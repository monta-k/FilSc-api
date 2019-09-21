class CreateTmdbMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :tmdb_movies do |t|
      t.string :title
      t.string :image
      t.string :homepage
      

      t.timestamps
    end
  end
end
