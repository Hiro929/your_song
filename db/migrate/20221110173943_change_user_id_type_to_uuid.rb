class ChangeUserIdTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    # usersテーブルにuuid追加
    add_column :users, :uuid, :uuid, null: false, default: 'gen_random_uuid()'

    # usersのidを消して、追加したuuidのカラム名をidに変更
    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    # usersのuuid化したidをprimary keyとして設定
    execute 'ALTER TABLE users ADD PRIMARY KEY (id);'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
