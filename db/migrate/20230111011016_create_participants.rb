class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.boolean :is_faculty
      t.string :email

      t.timestamps
    end
  end
end
