class CreateTaskTags < ActiveRecord::Migration[5.2]
  def change
    create_table :task_tags do |t|
      t.integer :task_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
