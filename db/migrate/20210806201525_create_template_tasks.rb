class CreateTemplateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :template_tasks do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.text :body, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end
  end
end
