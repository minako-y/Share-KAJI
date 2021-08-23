class Genre < ApplicationRecord
  has_many :tasks
  has_many :template_tasks
  has_many :monsters
  has_many :users, foreign_key: :weaknesses_genre_id
end
