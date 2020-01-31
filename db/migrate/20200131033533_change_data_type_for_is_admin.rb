class ChangeDataTypeForIsAdmin < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :isAdmin, :integer, :default => 0
  end
end
