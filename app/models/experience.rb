class Experience < ApplicationRecord
    belongs_to :program
    belongs_to :user
    has_many :experience_comments
    has_one :yelp_location
    
    attr_accessor :comments
    attr_accessor :average_rating
end