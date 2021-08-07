class Task < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  belongs_to :room
  belongs_to :user
  belongs_to :genre
end
