class AddBanReason < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ban_reason, :string
  end
end
