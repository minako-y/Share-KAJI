class Task < ApplicationRecord

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

  # def levelUp(user)
  #   # 経験値獲得の処理
  #   # 変数に現在の総経験値を入れる
  #   totalExp = user.exp
  #   # 得られた経験値をユーザーの経験値に加算、現在は10
  #   totalExp += 10
  #   # 加算した経験値をuserの総経験値を示す変数に入れ直して更新
  #   user.exp = totalExp
  #   user.update(exp: totalExp)

  #   # レベルアップの処理
  #   # 現在レベル+1のレベル設定レコードを取得
  #   levelSetting = LevelSetting.find_by(level: user.housework_level + 1)
  #   # 閾値と比較して、総経験値が上回ったら1レベル上げて更新
  #   if levelSetting.thresold <= user.experience_point
  #     user.housework_level = user.housework_level + 1
  #     user.update(housework_level: user.housework_level)
  #   end
  # end


end
