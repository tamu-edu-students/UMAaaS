class AddMoreLocationAttribute < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :street, :string
    add_column :experiences, :city, :string
    add_column :experiences, :postal_code, :string
  end
end
