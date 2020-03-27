class Experience < ApplicationRecord
    belongs_to :program
    belongs_to :user
    has_many :experience_comments
    has_one :yelp_location
    
    attr_accessor :comments
    attr_accessor :totalComments
    attr_accessor :average_rating
    
    def tagArray
        if(tags.nil?)
            tagArray = nil
        elsif(tags == ",")
            tagArray = nil
        else
            tagArray = tags.split(",")
            tagArray = tagArray.drop(1)
        end
        
        return tagArray
    end
end