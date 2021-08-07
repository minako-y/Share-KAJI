class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :task, through: :task_tag
  has_many :template_tasks, through: :task_tag

  validates :name, uniqueness: true
end
