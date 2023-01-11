class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.integer :participant_id
      t.references :program_id, null: false, foreign_key: true
      t.boolean :isFaculty
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
