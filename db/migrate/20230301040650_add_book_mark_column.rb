class AddBookMarkColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :bookmarked, :integer, :default => 0
  end
end
