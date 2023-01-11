class AddForeignKeyToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_reference :participants, :program, foreign_key: true
    add_reference :participants, :user, foreign_key: true
  end
end
