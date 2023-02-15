# frozen_string_literal: true

class Program < ApplicationRecord
    has_many :users
    has_many :tips
    has_many :experiences
    has_one_attached :banner_image
end
