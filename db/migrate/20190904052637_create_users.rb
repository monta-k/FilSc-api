class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :uid, null: false
      t.string :email, null: false
      t.string :filmarks_id

      t.timestamps
    end
  end
end
