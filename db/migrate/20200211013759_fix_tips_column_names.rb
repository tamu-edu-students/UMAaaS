# frozen_string_literal: true

class FixTipsColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :tips, :programs_id, :program_id
    rename_column :tips, :users_id, :user_id
  end
end
