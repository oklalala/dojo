# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all

category_list = [
  { name: "cat" },
  { name: "dog" },
  { name: "hamster" }
]

category_list.each do |category|
  Category.find_or_create_by(name: category[:name])
end
puts 'Category created!'

# Default admin
User.destroy_all
photo = "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"
User.create(
  id: 1,
  name: "Tony", 
  email: "123@123.123", 
  password: "123123", 
  role: "admin", 
  intro: "This is gourmet.",
  avatar: File.new(Rails.root.join('app', 'assets', 'images', photo)))

User.create(
  id: 2,
  name: "Cococa",
  email: "admin@example.com",
  password: "12345678",
  role: "admin",
  intro: "This is gourmet.",
  avatar: File.new(Rails.root.join('app', 'assets', 'images', photo)))
puts "Default admin created!"
