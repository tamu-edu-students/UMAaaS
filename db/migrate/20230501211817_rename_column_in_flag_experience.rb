class RenameColumnInFlagExperience < ActiveRecord::Migration[6.0]
  def change
    rename_column :flag_experiences, :type, :category
  end
end
