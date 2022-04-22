class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results, id: :uuid do |t|
      t.references :song, null: false, foreign_key: true, type: :uuid
      t.string :image, null: false
      t.integer :emotion, null: false

      t.timestamps
    end
  end
end
