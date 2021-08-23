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
        .merge(self.where('user_id = ? or official = ?', user.id, true))
  end

  # 出現モンスターからランダムに１つ抽出
  def self.monster_choice(user, genre)
    monsters = self.pop_monster(user, genre)
    range = monsters.count
    monsters[rand(range)]
  end

end
