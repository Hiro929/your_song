class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :artist, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
