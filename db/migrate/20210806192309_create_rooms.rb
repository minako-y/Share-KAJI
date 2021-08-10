class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.integer :complete_task, null: false, default: 0

      t.timestamps
    end
  end
end
