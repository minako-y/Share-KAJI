class TemplateTask < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags
  belongs_to :room
  belongs_to :user
  belongs_to :genre
end
