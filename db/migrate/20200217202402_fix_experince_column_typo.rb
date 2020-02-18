class FixExperinceColumnTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :experiences, :experince, :experience
  end
end
