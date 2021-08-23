# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 実装するジャンル
Genre.create!([{name: "料理"}, {name: "買い物"}, {name: "掃除"}, {name: "片付け"}, {name: "洗濯"}, {name: "その他"}, {name: "個人"}])

# テストアカウント
User.create!(
    email: "test1@test",
    password: "test1@test",
    name: "test1",
    weaknesses_genre_id: 1,
    current_room_id: 1
    )
Room.create!(
    name: "我が家",
    password: "000000"
    )
UserRoom.create!(
    user_id: 1,
    room_id: 1
    )

# 公式モンスター（仮）の作成。後日内容差し替え。作成者はテストアカウントに設定。
[
  [1, 1, File.open("./app/assets/images/monster/eric-han-Hd7vwFzZpH0-unsplash.jpg"), "料理ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 2, File.open("./app/assets/images/monster/james-sutton-dQ5G0h7sLno-unsplash.jpg"), "買い物ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 3, File.open("./app/assets/images/monster/ludemeula-fernandes-9UUoGaaHtNE-unsplash.jpg"), "掃除ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 4, File.open("./app/assets/images/monster/manja-vitolic-gKXKBY-C-Dk-unsplash.jpg"), "片付けねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 5, File.open("./app/assets/images/monster/mikhail-vasilyev-NodtnCsLdTE-unsplash.jpg"), "洗濯ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 6, File.open("./app/assets/images/monster/pacto-visual-cWOzOnSoh6Q-unsplash.jpg"), "その他ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 7, File.open("./app/assets/images/monster/yerlin-matu-GtwiBmtJvaU-unsplash.jpg"), "個人ねこ", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 1, File.open("./app/assets/images/monster/eric-han-Hd7vwFzZpH0-unsplash.jpg"), "料理ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 2, File.open("./app/assets/images/monster/james-sutton-dQ5G0h7sLno-unsplash.jpg"), "買い物ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 3, File.open("./app/assets/images/monster/ludemeula-fernandes-9UUoGaaHtNE-unsplash.jpg"), "掃除ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 4, File.open("./app/assets/images/monster/manja-vitolic-gKXKBY-C-Dk-unsplash.jpg"), "片付けねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 5, File.open("./app/assets/images/monster/mikhail-vasilyev-NodtnCsLdTE-unsplash.jpg"), "洗濯ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 6, File.open("./app/assets/images/monster/pacto-visual-cWOzOnSoh6Q-unsplash.jpg"), "その他ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true],
  [1, 7, File.open("./app/assets/images/monster/yerlin-matu-GtwiBmtJvaU-unsplash.jpg"), "個人ねこ2", "モンスターの説明が入ります。大体２文くらいだろうか・・・。豆知識みたいなのも入れたい。", true]
].each do |user_id, genre_id, img, name, memo, official|
  Monster.create!(
    { user_id: user_id, genre_id: genre_id, image: img, name: name, memo: memo, official: official}
  )
end

# テストアカウント用タスク
7.times do |n|
  Task.create!(
      room_id: 1,
      creator_id: 1,
      body: "test#{n + 1}test#{n + 1}test#{n + 1}test#{n + 1}test#{n + 1}test#{n + 1}",
      due_date: Time.now,
      genre_id: n + 1,
      monster_id: n + 1
  )
end

# レベル設定（仮）
100.times do |n|
  LevelSetting.create!(
    level: n + 2,
    thresold: (n + 1)*100
  )
end