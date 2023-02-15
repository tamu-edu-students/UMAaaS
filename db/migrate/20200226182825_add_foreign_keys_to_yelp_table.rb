# frozen_string_literal: true

class AddForeignKeysToYelpTable < ActiveRecord::Migration[6.0]
  def change
    add_reference :yelp_locations, :experience, foreign_key: true
  end
end
