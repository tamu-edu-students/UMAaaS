# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :program, optional: true
  has_many :tips
  has_many :experiences
  has_many :experience_comments
  has_many :tips, through: :helpful_votes
  has_many :experiences, through: :bookmarks
  has_one_attached :avatar 

  attr_accessor :img, :user_program_id
end
