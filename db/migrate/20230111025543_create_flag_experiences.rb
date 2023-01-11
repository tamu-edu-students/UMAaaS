class CreateFlagExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :flag_experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
