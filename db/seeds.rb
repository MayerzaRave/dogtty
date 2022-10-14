# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "cleaning data base"
Care.destroy_all
Desease.destroy_all
Pet.destroy_all
User.destroy_all
i = 0

10.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email(name: user.first_name)
  user.password = "123456"
  user.password_confirmation = "123456"
  user.contact = Faker::PhoneNumber.cell_phone_in_e164

  user.photo.attach(io: URI.open(IMAGES[i]), filename: "nes.png", content_type: "image/png")

  user.save!
  pet = Pet.new
  pet.user = user


  if rand < 0.5
    pet.specie = "cat"
    pet.name = Faker::Creature::Cat.name
    pet.breed = Faker::Creature::Cat.breed
  else
    pet.specie = "dog"
    pet.name = Faker::Creature::Dog.name
    pet.breed = Faker::Creature::Dog.breed
  end

  pet.weight_unit = "pounds"
  pet.weight = Faker::Number.decimal
  pet.birthday = Time.now
  pet.photo.attach(io: URI.open(PETS[i]), filename: "nes.png", content_type: "image/png")
  pet.save

  care = Care.new
  care.category = %w[health beauty play].sample
  care.schedule = Time.now
  care.status = %w[scheduled completed postponed].sample
  care.title = CARES.sample
  care.details = Faker::Lorem.paragraph
  care.pet = pet
  care.save

  desease = Desease.new
  desease.name = Faker::Lorem.word
  desease.at_age = Time.now
  desease.treatment = Faker::Lorem.paragraph
  desease.pet = pet

  desease.save!


  puts "#{user.first_name} created with #{pet.name} pet and #{desease.name} desease"
 i += 1
end
