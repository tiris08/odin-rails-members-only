# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
name = Faker::Name.name 
username =  Faker::Internet.username
email = Faker::Internet.email(name:  name, separators: '.')
user = User.new(name: name, 
             username: username,
             email: email,
             password: "123456",
             password_confirmation: "123456")
user.skip_confirmation!
user.save!