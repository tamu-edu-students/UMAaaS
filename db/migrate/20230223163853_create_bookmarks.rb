class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.text name
    end
    add_reference :bookmarks, :experience, foreign_key: true
    add_reference :bookmarks, :users, foreign_key: true
  end
end

