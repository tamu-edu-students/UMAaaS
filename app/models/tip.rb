# frozen_string_literal: true

class Tip < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :users, through: :helpful_votes

  attr_accessor :hasUserUpvoted, :hasUserDownvoted, :upvoteCount, :downvoteCount
end
