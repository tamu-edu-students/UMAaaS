# frozen_string_literal: true

class AddAdminColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :integer, default: 0
  end
end
