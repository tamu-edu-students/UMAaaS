# frozen_string_literal: true

class AddIsAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isAdmin, :boolean
    add_reference :users, :programs, foreign_key: true
  end
end
