class Task < ApplicationRecord

  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  belongs_to :room
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true
  belongs_to :genre

  enum progress: { 未実施: 0, 完了: 1, 保留: 2 }

  validates :body, presence: true
  validates :genre_id, presence: true
  # validates :due_date, presence: true
end
