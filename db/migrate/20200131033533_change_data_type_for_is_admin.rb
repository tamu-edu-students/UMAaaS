class ChangeDataTypeForIsAdmin < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :isAdmin, 'integer USING CAST(column_name AS integer)'
  end
end
