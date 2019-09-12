class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :length, null: false
      t.string :score, null: false
      t.string :image, null: false
      t.string :link, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
