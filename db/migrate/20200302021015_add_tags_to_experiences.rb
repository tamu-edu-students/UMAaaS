# frozen_string_literal: true

class AddTagsToExperiences < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :tags, :string
  end
end
