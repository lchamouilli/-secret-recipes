# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "json"

Comment.destroy_all
Recipe.destroy_all
User.destroy_all

puts 'Create users'
puts '------------'
user1 = User.create(
  firstname: "Lionel",
  lastname: "Chamouilli",
  email: "lionel.chamouilli@gmail.com",
  password: "123456",
  password_confirmation: "123456"
)

puts 'User created'
puts '------------'

puts 'Create Recipes'
puts '------------'

api_key = '9ebb54fc2f864086853cbe97d9f7a9d2'
id = 716445

10.times do
  url = "https://api.spoonacular.com/recipes/#{id}"
  puts "Importing recipes with #{id}"
  recipe = JSON.parse(URI.open("#{url}/information?apiKey=#{api_key}&includeanalyzeInstructions=true").read)
  puts "Creating #{recipe['title']}"
  Recipe.create(
    title: recipe['title'],
    time_cook: recipe['readyInMinutes'],
    description: recipe['instructions'],
    photo: recipe['image'],
    user: user1
  )
  id += 1
end
puts "Recipe1 created"
