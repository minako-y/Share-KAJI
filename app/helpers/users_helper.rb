module UsersHelper
  def to_next_level(user)
    next_thresold = LevelSetting.where(level: user.housework_level + 1).pluck(:thresold)
    "#{next_thresold.first - user.exp}"
  end
end
