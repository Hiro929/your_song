class AddSongspotifyurlToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :spotify_url, :string, null: false

    change_column :songs, :acousticness, :float, null: false
    change_column :songs, :danceability, :float, null: false
    change_column :songs, :energy, :float, null: false
    change_column :songs, :tempo, :float, null: false
    change_column :songs, :valence, :float, null: false
    change_column :songs, :preview_url, :string, null: false
  end
end
