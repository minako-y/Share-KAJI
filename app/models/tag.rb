class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags
  has_many :template_tasks, through: :task_tags

  validates :name, uniqueness: true

  # タスクのタグ一覧
  def self.task_tag_used_in_room(room_id, progress)
    joins(:tasks).distinct
                 .where(tasks: { room_id: room_id, progress: progress })
  end

  # テンプレートタスクのタグ一覧
  def self.template_task_tag_used_in_room(room_id, user_id)
    joins(:template_tasks).distinct
                          .where(template_tasks: { room_id: room_id })
                          .where.not(template_tasks: { genre_id: 7 })
                          .or(Tag.joins(:template_tasks).distinct
                          .where(template_tasks: { user_id: user_id, genre_id: 7 }))
  end
end
