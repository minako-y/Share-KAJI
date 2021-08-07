class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :rooms
end
