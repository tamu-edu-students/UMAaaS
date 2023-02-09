# frozen_string_literal: true

class Program < ApplicationRecord
<<<<<<< HEAD
  has_many :users
  has_many :tips
  has_many :experiences
  # has_one :banner_image
end
=======
    has_many :users
    has_many :tips
    has_many :experiences
    has_one_attached :banner_image
    
end
>>>>>>> 97f6182a8e92265c160bb0ea2ec44ec7d7332dcc
