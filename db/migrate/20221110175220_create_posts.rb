class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :track_id, null: false
      t.integer :emotional_state, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
