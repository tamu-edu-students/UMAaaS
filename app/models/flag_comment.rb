class FlagComment < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  
  attr_accessor :hasUserFlagged
end
