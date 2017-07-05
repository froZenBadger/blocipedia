require 'random_data'

#Create Users
5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

#Create Wikis
50.times do
  wiki = Wiki.create!(
    user:   users.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end

# Create a standard member
member = User.create!(
  email:    'standardmember@example.com',
  password: 'helloworld'
)

# Create a premium member
premium = User.create!(
  email:    'premiummember@example.com',
  password: 'helloworld',
  role:     'premium'
)

#Create Admin
admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
