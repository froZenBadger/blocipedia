FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'
    # initialize_with { new(email, password) }
  end
end
#   #pw = RandomData.random_sentence
#   factory :user do
#     sequence(:email){|n| "user#{n}@factory.com" }
#     password pw
#     #password_confirmation pw
#     #confirmed_at Date.today
#   end
# end
