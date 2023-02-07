class CreateFlagTips < ActiveRecord::Migration[6.0]
  def change
    create_table :flag_tips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tip, null: false, foreign_key: true
      t.integer :flag 

      t.timestamps
    end
  end
end
