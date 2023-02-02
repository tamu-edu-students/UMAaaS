class User < ApplicationRecord
    belongs_to :program, optional: true
    has_many :tips
    has_many :experiences
    has_many :experience_comments
    has_many :helpful_votes, through: :tips
    
    attr_accessor :img
    attr_accessor :user_program_id
end
