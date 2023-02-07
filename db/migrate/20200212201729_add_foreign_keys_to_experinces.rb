# frozen_string_literal: true

class AddForeignKeysToExperinces < ActiveRecord::Migration[6.0]
  def change
    add_reference :experinces, :program, foreign_key: true
    add_reference :experinces, :user, foreign_key: true
  end
end
