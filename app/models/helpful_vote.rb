# frozen_string_literal: true

class HelpfulVote < ApplicationRecord
  belongs_to :tip
  belongs_to :user
end
