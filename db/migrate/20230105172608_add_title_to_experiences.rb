class AddTitleToExperiences < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :title, :string
  end
end
