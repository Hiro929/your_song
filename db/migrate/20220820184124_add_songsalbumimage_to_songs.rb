class AddSongsalbumimageToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :album_image, :string, null: false
  end
end
