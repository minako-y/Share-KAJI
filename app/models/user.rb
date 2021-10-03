class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :created_tasks, class_name: 'Tasks', foreign_key: 'creator_id', dependent: :destroy
  has_many :finished_tasks, class_name: 'Tasks', foreign_key: 'executor_id', dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy # 送った通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy # 受け取った通知
  belongs_to :weaknesses_genre, class_name: 'Genre', foreign_key: :weaknesses_genre_id
  belongs_to :current_room, class_name: 'Room', foreign_key: :current_room_id, optional: true
  attachment :profile_image

  validates :name, presence: true, length: { maximum: 20 }

  # タスク完了数増加〜経験値獲得〜レベルアップまでの処理
  def task_completed(user, task)
    # タスク完了数＋１
    user.complete_task += 1

    # 経験値獲得
    total_exp = user.exp
    # ユーザーの苦手な家事と一致すれば多めに加算される
    task.genre_id == user.weaknesses_genre_id ? total_exp += 20 : total_exp += 10
    user.exp = total_exp
    user.update(exp: total_exp)

    # レベルアップの処理
    # 現在レベル+1のレベル設定レコードを取得
    level_setting = LevelSetting.find_by(level: user.housework_level + 1)
    # 閾値と比較して、総経験値が上回ったら1レベル上げて更新
    return unless level_setting.thresold <= user.exp

    user.housework_level = user.housework_level + 1
    user.update(housework_level: user.housework_level)
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
      user.weaknesses_genre_id = 1
    end
  end
end
