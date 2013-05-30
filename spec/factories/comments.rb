# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentences.join(" ") }
    user_id { rand(10) }
    is_moderated { [true, false].sample }
    opinion { ["positive", "negative", "neutral"].sample if is_moderated  }
    article
    created_at { rand(1.month).ago }
  end
end
