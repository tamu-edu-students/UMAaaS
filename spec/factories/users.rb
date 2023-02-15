
FactoryBot.define do
  factory :user do
    sequence(:uid) { |n| n }
    name { 'Test User' }
    email { 'test@tamu.edu' }
    image { 'http://test_image.com' }
    banned { false }
  end
   factory :banned_user do
    uid { '12345' }
    name { 'Test User' }
    email { 'test@tamu.edu' }
    banned { true }
  end
end