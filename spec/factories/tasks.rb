FactoryBot.define do
  factory :task do
    body { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4) }
    due_date { Time.now }
    genre_id { FactoryBot.create(:genre, :a).id }
    monster_id { FactoryBot.create(:monster).id }

    association :creator, factory: :user
    association :monster
  end
end