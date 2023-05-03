class AddFlagType < ActiveRecord::Migration[6.0]
  def change
    add_column :flag_experiences, :category, :string
  end
end
