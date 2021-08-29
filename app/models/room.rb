class Room < ApplicationRecord

  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :users, foreign_key: :current_room_id
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
