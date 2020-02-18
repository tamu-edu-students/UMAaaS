class CreateExperienceCommentsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :experience_comments do |t|
      t.text :comment
      t.integer :rating
      t.timestamps
    end
  end
end
