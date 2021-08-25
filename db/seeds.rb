# 実装するジャンル
Genre.create!([{name: "料理"}, {name: "買い物"}, {name: "掃除"}, {name: "片付け"}, {name: "洗濯"}, {name: "その他"}, {name: "個人"}])

# テストアカウント
[
  ["official@test", "official@test", "公式アカウント", 1, 1],
  ["test1@test", "test1@test", "ichika", 3, 1],
  ["test2@test", "test2@test", "ニイナ", 4, 1],
  ["test3@test", "test3@test", "さん太", 1, 1],
  ["test4@test", "test4@test", "四ツ谷", 2, 2]
].each do |email, password, name, weaknesses_genre_id, current_room_id|
  User.create!(
    {email: email, password: password, name: name, weaknesses_genre_id: weaknesses_genre_id, current_room_id: current_room_id}
    )
end

Room.create!([{name: "1LDK", password: "000000"}, {name: "ワンルーム", password: "000000"}])

UserRoom.create!([
  {user_id: 2, room_id: 1}, {user_id: 3, room_id: 1}, {user_id: 4, room_id: 1}, {user_id: 5, room_id: 2}
  ])

# 公式モンスターの作成。作成者は公式アカウントに設定。
[
  [1, 1, File.open("./app/assets/images/monster/cooKING.png"), "クッキング", "料理の王様。時間通りに美味しいものを作れと言わんばかりの厳しい目が光る。怒らせたら面倒なので早めに相手をしてあげよう。", true],
  [1, 2, File.open("./app/assets/images/monster/kawaknight.png"), "カワナイト", "駄々っ子ナイト。これも欲しいな、あれの買い置きなかったな・・・そう思わせて無駄な買い物を増やしてくる厄介な子。", true],
  [1, 3, File.open("./app/assets/images/monster/fumibanashi.png"), "フミバナシ", "ワンルームに現れやすい。物が多く、よどんだ空気のお部屋が大好き。一度一掃してしまえば、世界が変わるかもしれない。", true],
  [1, 3, File.open("./app/assets/images/monster/soujikiller.png"), "ソウジキラー", "何でも吸い込む（噛み砕く？）掃除機。お部屋が汚いと轟音で唸り出すため、こまめに対処しよう。", true],
  [1, 3, File.open("./app/assets/images/monster/kabikabizombi.png"), "カビカビゾンビ", "気を抜くとお風呂場に出現しているゾンビ。しぶとくて厄介。稀にキッチンの食材にも出現する。その場合は諦めて処分しよう。", true],
  [1, 4, File.open("./app/assets/images/monster/araimognome.png"), "アライモノーム", "手先が器用な彼らだが、洗い物は全くしてくれない（そりゃそうか）。こら、そこは椅子ではないぞ！", true],
  [1, 5, File.open("./app/assets/images/monster/laundri.png"), "ランドリ", "汚れた服を持って無言の圧力をかけてくるカラス。そんな目で見ないでほしい。おみ足が実はとってもキュート。", true],
  [1, 5, File.open("./app/assets/images/monster/sentakumonoyama.png"), "センタクモノヤマ", "畳んでいない洗濯物があると、どこまでも押し出ししてくるおすもうさん。部屋の隅に追いやられる前に対処しよう。", true],
  [1, 6, File.open("./app/assets/images/monster/osampowanko.png"), "オサンポワンコ", "潤んだまなざし。期待の溢れるしっぽ。愛しの家族に可愛くアピールされては、行くしかあるまい。散歩は自分の健康にもいいぞ！", true],
  [1, 7, File.open("./app/assets/images/monster/ginkoughost.png"), "ギンコウゴースト", "ああ、財布のお金がなくなってしまった。もしかしたら、物欲という名のおばけに取り憑かれているかもしれないな。", true]
].each do |user_id, genre_id, img, name, memo, official|
  Monster.create!(
    { user_id: user_id, genre_id: genre_id, image: img, name: name, memo: memo, official: official}
  )
end

# レベル設定
100.times do |n|
  LevelSetting.create!(
    level: n + 2,
    thresold: (n + 1)*100
  )
end