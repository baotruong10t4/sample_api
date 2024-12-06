# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(name:  "Example User",
             user_name: "example_user",
             email: "example@railstutorial.org",
             password:              "Pass@12345",
             password_confirmation: "Pass@12345",
             activated: true,
             activated_at: Time.zone.now)

user = User.first

10.times do
  product_name = Faker::Commerce.product_name
  product_price = Faker::Commerce.price
  user.products.create!(name: product_name, price: product_price)
end
