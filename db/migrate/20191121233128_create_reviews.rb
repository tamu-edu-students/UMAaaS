# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :business_id
      t.string :user_email
      t.text :comment
      t.integer :rating
      t.integer :price
      t.integer :safety
      t.integer :service
      t.boolean :cash_only
      t.boolean :english
      t.boolean :tips
      t.boolean :wifi
      t.boolean :wheelchair
      t.string :name
      t.timestamps
    end
  end
end
