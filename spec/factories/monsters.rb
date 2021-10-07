require "refile"
require "refile/file_double"

FactoryBot.define do
  factory :monster do
    genre_id { FactoryBot.create(:genre, :a).id }
    image { Refile::FileDouble.new("dummy") }
    name { Faker::Lorem.characters(number: 10) }
    memo { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)}
  end
end
