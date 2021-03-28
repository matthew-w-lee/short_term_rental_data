class AddFieldsToListings < ActiveRecord::Migration[5.2]
  def change
  	add_column :listings, :airdna_rating, :decimal
  	add_column :listings, :occ, :decimal
  	add_column :listings, :airdna_longitude, :decimal
  	add_column :listings, :airdna_latitude, :decimal
  	add_column :listings, :adr, :decimal
  	add_column :listings, :revenue, :decimal
  	add_column :listings, :number_of_reviews, :decimal
  	add_column :listings, :homeaway_property_id, :string
  	add_column :listings, :airdna_neighborhood_ids, :text, array: true, default: []
  	add_column :listings, :airdna_zipcode_ids, :text, array: true, default: []
  	add_index :listings, :occ
  	add_index :listings, :airdna_longitude
  	add_index :listings, :airdna_latitude  	
  	add_index :listings, :adr
  	add_index :listings, :revenue
  	add_index :listings, :number_of_reviews
  	add_index :listings, :homeaway_property_id
  end
end
