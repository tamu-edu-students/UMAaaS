class HelpfulVote < ApplicationRecord
    belongs_to :tip
    belongs_to :user
end