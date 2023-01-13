class Program < ApplicationRecord
    has_many :users
    has_many :tips
    has_many :experiences
    # has_one :banner_image
    
end