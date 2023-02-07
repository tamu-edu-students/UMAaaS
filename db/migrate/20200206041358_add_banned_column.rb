# frozen_string_literal: true

class AddBannedColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :banned, :boolean, default: false
  end
end
