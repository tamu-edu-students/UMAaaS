class CreateExperincesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :experinces do |t|
      t.text :experince
      t.integer :rating
      t.timestamps
    end
  end
end
