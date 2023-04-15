class AddLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :location, :string
  end
end
