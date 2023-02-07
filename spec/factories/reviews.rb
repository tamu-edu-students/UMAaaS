# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    business_id 'MyString'
    user_email 'MyString'
    comment 'MyText'
    rating 1
    price 1
    safety 1
    service 1
    cash_only false
    english false
    tips false
    wifi false
    wheelchair false
  end
end
