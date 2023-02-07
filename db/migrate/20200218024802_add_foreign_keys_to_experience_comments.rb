# frozen_string_literal: true

class AddForeignKeysToExperienceComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :experience_comments, :experience, foreign_key: true
    add_reference :experience_comments, :user, foreign_key: true
  end
end
