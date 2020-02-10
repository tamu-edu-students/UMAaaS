class AddProgramsColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :location, :string
    add_column :programs, :disabled, :boolean, :default => false
  end
end
