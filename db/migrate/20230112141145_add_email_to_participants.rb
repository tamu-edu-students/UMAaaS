# frozen_string_literal: true

class AddEmailToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :email, :string
  end
end
