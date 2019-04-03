User.create!(name: "Master Mind",
             email: "example@railstutorial.org",
             password: "123456789",
             password_confirmation: "123456789",
             admin: 1)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456789"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password)
end
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
