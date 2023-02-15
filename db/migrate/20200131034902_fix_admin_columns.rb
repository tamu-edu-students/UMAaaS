# frozen_string_literal: true

class FixAdminColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :isAdmin
    remove_column :users, :admin
    add_column :users, :admin, :boolean, default: false
  end
end
