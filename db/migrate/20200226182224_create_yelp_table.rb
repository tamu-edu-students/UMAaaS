class CreateYelpTable < ActiveRecord::Migration[6.0]
  def change
    create_table :yelp_locations do |t|
      t.string :name
      t.string :address
      t.string :alias
      t.string :yelp_id
      t.string :url
      t.string :image_url
      t.string :rating
      t.string :yelp_tags
    end
  end
end
