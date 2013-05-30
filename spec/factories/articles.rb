# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Name.title }
    content { Faker::Lorem.paragraphs(rand(2..8)).join(' ') }
    user_id {rand(10) }

    factory :article_with_comments do
      ignore do
        comments_count 20
      end

      after :create do |article, evaluator|
        FactoryGirl.create_list :comment, evaluator.comments_count, :article_id => article.id
      end
    end

  end
end
