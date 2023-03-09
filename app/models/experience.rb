# frozen_string_literal: true

class Experience < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :experience_comments
  has_one :yelp_location
  has_one_attached :image
  has_many :users, through: :flag_experiences
    
  attr_accessor :hasUserFlagged
  attr_accessor :flagCount
    

  attr_accessor :comments, :totalComments, :average_rating, :commented

  def tagArray
    if tags.nil?
      tagArray = nil
    elsif tags == ','
      tagArray = nil
    else
      tagArray = tags.split(',')
      tagArray = tagArray.drop(1)
    end

    tagArray
  end
end
