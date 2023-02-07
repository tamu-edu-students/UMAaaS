# frozen_string_literal: true

class CreateHelpfulTable < ActiveRecord::Migration[6.0]
  def change
    create_table :helpful_votes do |t|
      t.integer :vote
    end
  end
end
