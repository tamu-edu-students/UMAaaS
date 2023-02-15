# frozen_string_literal: true

class AddForeignKeyToHelpful < ActiveRecord::Migration[6.0]
  def change
    add_reference :helpful_votes, :tip, foreign_key: true
    add_reference :helpful_votes, :user, foreign_key: true
  end
end
