class CreateMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :monsters do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :image_id, null: false
      t.string :name, null: false
      t.string :memo, null: false
      t.boolean :official, null: false, default: false

      t.timestamps
    end
  end
end
