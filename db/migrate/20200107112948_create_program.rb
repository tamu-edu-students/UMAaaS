# frozen_string_literal: true

class CreateProgram < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string 'name'
      # t.string 'city'
      # t.string 'country'
      t.string 'region'
    end
  end
end
