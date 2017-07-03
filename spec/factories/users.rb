FactoryGirl.define do
  pw = RandomData.random_sentence
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
  end
end
