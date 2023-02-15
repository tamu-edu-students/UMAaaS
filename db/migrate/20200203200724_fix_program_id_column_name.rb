# frozen_string_literal: true

class FixProgramIdColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :programs_id, :program_id
  end
end
