class TemplateTask < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  belongs_to :room
  belongs_to :user
  belongs_to :genre

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
