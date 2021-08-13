class Monster < ApplicationRecord
  has_many :tasks
  belongs_to :genre
  belongs_to :user
  attachment :image

  validates :name, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true
  validates :memo, presence: true


  # ジャンル内で公式モンスターと自作モンスターを合計
  def self.pop_monster(user, genre)
    self.where(genre_id: genre.id)
        .merge(self.where(user_id: user.id).or(self.where(official: true)))
  end

  # 出現モンスターからランダムに１つ抽出
  def self.monster_choice(user, genre)
    range = self.pop_monster(user, genre).count + 1
    self.pop_monster(user, genre)[rand(range)]
  end

end
