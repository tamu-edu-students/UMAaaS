class Participant < ApplicationRecord
  belongs_to :program_id
  belongs_to :user_id
end
