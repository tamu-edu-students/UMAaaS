class CreateFlagTips < ActiveRecord::Migration[6.0]
  def change
    create_table :flag_tips do |t|
      t.integer :flag
      t.references :user, null: false, foreign_key: true
      t.references :tip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
