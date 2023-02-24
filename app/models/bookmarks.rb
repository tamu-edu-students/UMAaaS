class Bookmark < ApplicationRecord
    belongs_to :user
    has_one :experience
    
    attr_accessor :name
end