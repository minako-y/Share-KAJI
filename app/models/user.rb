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
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  belongs_to :weaknesses_genre, class_name: 'Genre', foreign_key: :weaknesses_genre_id
  belongs_to :my_room, class_name: 'Room', foreign_key: :my_room_id, optional: true
  attachment :profile_image

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
