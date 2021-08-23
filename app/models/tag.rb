class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags
  has_many :template_tasks, through: :task_tags

  validates :name, uniqueness: true
end
