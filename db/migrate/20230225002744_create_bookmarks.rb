class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
    end
    add_reference :bookmarks, :experience, foreign_key: true
    add_reference :bookmarks, :user, foreign_key: true
  end
end