# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Event.destroy_all
Attendance.destroy_all
Event.destroy_all

30.times do 
    last_name = Faker::Name.last_name
    first_name = Faker::Name.first_name
    User.create(email: "#{first_name}.#{last_name}@yopmail.com", description: Faker::Hipster.sentence(word_count: rand(10..20)), first_name: first_name, last_name: last_name, password: first_name + "123")
end

x = User.all.length

(x / 3).times do    
    Event.create(start_date: Time.now + rand(300)*rand(60)*rand(60), duration: (rand(120) / 5) * 5, description: Faker::Hipster.sentence(word_count: rand(10..20)), price: rand(1..1000), location: Faker::Address.full_address, administrator: User.all.sample, title: Faker::Lorem.sentence(word_count: 3))
    Event.last.scene.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'event_default.jpg')), filename: 'event_default.jpg', content_type: 'image/png')
end

(x * 0.8).to_i.times do 
    Attendance.create(stripe_customer_id: Faker::Lorem.word, attendant: User.all.sample, attended_event: Event.all.sample)
end

User.create(email: "boris.alfoldi@yopmail.com", description: Faker::Hipster.sentence(word_count: rand(10..20)), first_name: "Boris", last_name: "Alfoldi", password: "Boris" + "123",web_master: true)
