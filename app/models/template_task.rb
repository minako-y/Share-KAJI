class TemplateTask < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  belongs_to :room
  belongs_to :user
  belongs_to :genre

  # テンプレートタスクの一覧表示
  # 他人の個人テンプレタスクが表示されないようにする
  def self.template_task_list(room_id, user_id, page)
    where(room_id: room_id)
      .where.not(genre_id: 7)
      .or(where(user_id: user_id, genre_id: 7))
      .page(page).per(10)
  end

  # テンプレートタスクへ保存
  def self.create_template_task(task, user, tag_list)
    template_task = new(
      user_id: user.id,
      room_id: task.room_id,
      body: task.body,
      genre_id: task.genre_id
    )
    template_task.save
    # テンプレートタスクのタグを保存
    template_task.save_tags(tag_list)
  end

  # テンプレートタスクのタグを保存
  def save_tags(savetask_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    remove_tags = current_tags - savetask_tags
    new_tags = savetask_tags - current_tags

    remove_tags.each do |rm_tag|
      tags.delete Tag.find_by(name: rm_tag)
    end

    new_tags.each do |new|
      new_task_tag = Tag.find_or_create_by(name: new)
      tags << new_task_tag
    end
  end
end
