# frozen_string_literal: true

class Program < ApplicationRecord
    has_many :users
    has_many :tips
    has_many :experiences
    has_one_attached :banner
    has_many :flag_tips, through: :tips, source: :flag_tips
    has_many :flag_experiences, through: :experiences, source: :flag_experiences
end
