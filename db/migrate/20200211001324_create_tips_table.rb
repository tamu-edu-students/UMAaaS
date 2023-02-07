# frozen_string_literal: true

class CreateTipsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tips do |t|
      t.text :tip

      t.timestamps
    end
  end
end
