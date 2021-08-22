class Task < ApplicationRecord
  attr_accessor :template_task # attr_reader attr_writer
  attr_accessor :tag_name

  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  belongs_to :room
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true
  belongs_to :genre
  belongs_to :monster

  enum progress: { 未実施: 0, 完了: 1, 保留: 2 }

  validates :body, presence: true
  validates :genre_id, presence: true
  validates :due_date, presence: true


  def save_tags(savetask_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    remove_tags = current_tags - savetask_tags
    new_tags = savetask_tags - current_tags

    remove_tags.each do |rm_tag|
      self.tags.delete Tag.find_by(name: rm_tag)
    end

    new_tags.each do |new|
      new_task_tag = Tag.find_or_create_by(name: new)
      self.tags << new_task_tag
    end
  end

end
