class User < ApplicationRecord
    belongs_to :program, optional: true
    has_many :tips
    has_many :experiences
    has_many :experience_comments
    has_many :tips, through: :helpful_votes
    
    attr_accessor :img
end
