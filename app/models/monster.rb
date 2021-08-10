class Monster < ApplicationRecord
  has_many :tasks
  belongs_to :genre
  belongs_to :user
  attachment :image
end
