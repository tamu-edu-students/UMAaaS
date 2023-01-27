class CreateFlagComments < ActiveRecord::Migration[6.0]
  def change
    create_table :flag_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :flag 

      t.timestamps
    end
  end
end
