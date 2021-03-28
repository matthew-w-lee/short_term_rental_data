class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :amenity_ids
      t.decimal :avg_rating
      t.string :badges
      t.string :bathroom_label
      t.integer :bathrooms
      t.string :bed_label
      t.string :bedroom_label
      t.integer :bedrooms
      t.integer :beds
      t.string :city
      t.string :guest_label
      t.string :host_languages
      t.string :host_thumbnail_url_small
      t.string :host_thumbnail_url
      t.integer :listing_id
      t.boolean :is_business_travel_ready
      t.boolean :is_fully_refundable
      t.boolean :is_host_highly_rated
      t.boolean :is_new_listing
      t.boolean :is_superhost
      t.string :kicker_content
      t.decimal :lat
      t.decimal :lng
      t.string :localized_city
      t.string :localized_neighborhood
      t.string :main_section_message
      t.string :name
      t.string :neighborhood
      t.integer :person_capacity
      t.string :picture
      t.integer :picture_count
      t.string :picture_url
      t.string :picture_urls
      t.string :preview_amenities
      t.string :preview_amenity_names
      t.string :preview_encoded_png
      t.integer :property_type_id
      t.string :public_address
      t.integer :reviews_count
      t.string :room_and_property_type
      t.string :room_type
      t.string :room_type_category
      t.string :scrim_color
      t.boolean :show_structured_name
      t.string :space_type
      t.integer :star_rating
      t.string :star_rating_color
      t.integer :tier_id
      t.references :host, foreign_key: true

      t.timestamps
    end
    add_index :listings, :listing_id
    add_index :listings, :localized_city
    add_index :listings, :localized_neighborhood
  end
end
