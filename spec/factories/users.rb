FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    program_id { FactoryBot.create(:program).id }
    banned false
  end
end