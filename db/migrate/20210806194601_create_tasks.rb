class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :room_id, null: false
      t.integer :creator_id, null: false
      t.integer :executor_id, null: false, default: ""
      t.text :body, null: false
      t.datetime :due_date, null: false
      t.datetime :finish_date, null: false, default: ""
      t.integer :genre_id, null: false
      t.integer :progress, null: false

      t.timestamps
    end
  end
end
