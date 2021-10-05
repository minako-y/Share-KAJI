FactoryBot.define do
  factory :room do
    name { Faker::Lorem.characters(number: 5) }
    password { 'password' }

    after(:create) do |room|
      create(:user_room, user: create(:user), room: room)
    end
  end
end
