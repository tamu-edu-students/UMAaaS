class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :program, null: false, foreign_key: true
      t.boolean :isFaculty
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
