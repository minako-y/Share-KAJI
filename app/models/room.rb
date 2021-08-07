class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :users, foreign_key: :my_room_id
  has_many :tasks, dependent: :destroy

  validates :room_password, presence: true, length: { minimum: 6 }
end
