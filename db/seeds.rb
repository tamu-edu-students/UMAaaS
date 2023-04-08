# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

#   Character.create(name: 'Luke', movie: movies.first)

# reviews.each do |review|
#  Review.create!(review)
# end

Program.create!(name: 'Singapore CSCE Wintermester', region: 'Asia')
Program.create!(name: 'Greece CSCE Wintermester', region: 'Europe')
singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
User.create!(admin: true, program: singapore, id: 1, img: 'https://picsum.photos/200/300/?random', name: 'Test User',
             email: 'testuser@gmail.com')
User.create!(admin: true, program: singapore, id: 2, img: nil, name: 'Tejasri Swaroop Boppana',
             email: 'tejasriboppana22@gmail.com')
Participant.create(email: 'tejasriboppana22@gmail.com', program: singapore)
