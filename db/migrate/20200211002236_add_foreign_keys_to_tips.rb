class AddForeignKeysToTips < ActiveRecord::Migration[6.0]
  def change
    add_reference :tips, :programs, foreign_key: true
    add_reference :tips, :users, foreign_key: true
  end
end
