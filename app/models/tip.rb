class Tip < ApplicationRecord
    belongs_to :program
    belongs_to :user
    has_many :users, through: :helpful_votes
    has_many :users, through: :flag_tips
    
    attr_accessor :hasUserFlagged
    attr_accessor :flagCount
    
    attr_accessor :hasUserUpvoted
    attr_accessor :hasUserDownvoted
    attr_accessor :upvoteCount
    attr_accessor :downvoteCount
    
end