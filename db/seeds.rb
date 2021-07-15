# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
# users
50.times do |n|
  name = Faker::Name.name 
  username =  "#{Faker::Internet.username}" + "#{n+1}"
  email = Faker::Internet.email(name:  name, separators: '.')
  user = User.new(name: name, 
             username: username,
             email: email,
             password: "123456",
             password_confirmation: "123456")
  user.skip_confirmation!
  user.save!
end

users = User.first(10)
# posts
5.times do
  body = Faker::Lorem.sentence(word_count: 150)
  title = Faker::Lorem.sentence(word_count: 5)
  users.each { |u| u.posts.create!(title: title, body: body)}
end
# likes

posts = Post.all
users = User.all
posts = posts[10..40]
posts.each { |post| post.like(users)[44] }
posts = posts[30..40]
posts.each { |post| post.like(users[33]) }
5.times do |n|
  posts = posts[40..50]
  posts.each { |post| post.like(users[n+1]) }
end