class Task < ApplicationRecord
  attr_accessor :template_task, # attr_reader attr_writer
                :tag_name

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

  # タスク通知作成メソッド
  def create_notification_task!(current_user, action)
    # 自分以外の同じルームの人に通知を送信する
    temp_ids = User.joins(:rooms).where(rooms: { id: current_user.current_room_id }).where.not(id: current_user.id).select(:id)
    temp_ids.each do |temp_id|
      save_notification_task!(current_user, temp_id['id'], action)
    end
  end

  # タスク作成時、完了時の通知登録メソッド
  def save_notification_task!(current_user, visited_id, action)
    notification = current_user.active_notifications.new(
      task_id: id,
      visited_id: visited_id,
      action: action
    )
    notification.save! if notification.valid?
  end

  # タスクのメッセージ通知作成メソッド
  def create_notification_message!(current_user, message_id, task_id)
    # 自分以外の同じルームの人に通知を送信する
    temp_ids = User.joins(:rooms).where(rooms: { id: current_user.current_room_id }).where.not(id: current_user.id).select(:id)
    temp_ids.each do |temp_id|
      save_notification_message!(current_user, message_id, temp_id['id'], task_id)
    end
  end

  # メッセージ送信時の通知登録メソッド
  def save_notification_message!(current_user, message_id, visited_id, task_id)
    notification = current_user.active_notifications.new(
      task_id: task_id,
      message_id: message_id,
      visited_id: visited_id,
      action: 'message'
    )
    notification.save! if notification.valid?
  end
end
