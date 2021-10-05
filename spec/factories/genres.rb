FactoryBot.define do
  factory :genre do
    trait :a do
      name { '料理' }
    end

    trait :b do
      name { '買い物' }
    end

    trait :c do
      name { '掃除' }
    end

    trait :d do
      name { '片付け' }
    end

    trait :e do
      name { '洗濯' }
    end

    trait :f do
      name { 'その他' }
    end

    trait :g do
      name { '個人' }
    end
  end
end
