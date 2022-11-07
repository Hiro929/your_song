class AddBestSongToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :best_song, :string
  end
end
