# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

#   Character.create(name: 'Luke', movie: movies.first)

#reviews.each do |review|
#  Review.create!(review)
#end

Program.create!(:name => "Singapore CSCE Wintermester", :region => "Asia")
Program.create!(:name => "Greece CSCE Wintermester", :region => "Europe")

User.create!(:admin => false,:program_id => nil,:id => 4, :img => nil)