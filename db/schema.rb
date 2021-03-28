# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_10_190936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_dates", force: :cascade do |t|
    t.string "dynamic_pricing_updated_at"
    t.text "conditions_json"
    t.bigint "listing_id"
    t.datetime "taken_at"
    t.date "date"
    t.boolean "available"
    t.boolean "available_for_checkin"
    t.integer "max_nights"
    t.integer "min_nights"
    t.text "price_json"
    t.decimal "local_price"
    t.decimal "local_adjusted_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available"], name: "index_booking_dates_on_available"
    t.index ["available_for_checkin"], name: "index_booking_dates_on_available_for_checkin"
    t.index ["date"], name: "index_booking_dates_on_date"
    t.index ["listing_id"], name: "index_booking_dates_on_listing_id"
    t.index ["local_price"], name: "index_booking_dates_on_local_price"
    t.index ["min_nights"], name: "index_booking_dates_on_min_nights"
    t.index ["taken_at"], name: "index_booking_dates_on_taken_at"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "first_name"
    t.boolean "has_profile_pic"
    t.integer "host_id"
    t.boolean "is_superhost"
    t.string "picture_url"
    t.string "smart_name"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name"], name: "index_hosts_on_first_name"
    t.index ["host_id"], name: "index_hosts_on_host_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "amenity_ids"
    t.decimal "avg_rating"
    t.string "badges"
    t.string "bathroom_label"
    t.integer "bathrooms"
    t.string "bed_label"
    t.string "bedroom_label"
    t.integer "bedrooms"
    t.integer "beds"
    t.string "city"
    t.string "guest_label"
    t.string "host_languages"
    t.string "host_thumbnail_url_small"
    t.string "host_thumbnail_url"
    t.integer "listing_id"
    t.boolean "is_business_travel_ready"
    t.boolean "is_fully_refundable"
    t.boolean "is_host_highly_rated"
    t.boolean "is_new_listing"
    t.boolean "is_superhost"
    t.string "kicker_content"
    t.decimal "lat"
    t.decimal "lng"
    t.string "localized_city"
    t.string "localized_neighborhood"
    t.string "main_section_message"
    t.string "name"
    t.string "neighborhood"
    t.integer "person_capacity"
    t.string "picture"
    t.integer "picture_count"
    t.string "picture_url"
    t.string "picture_urls"
    t.string "preview_amenities"
    t.string "preview_amenity_names"
    t.string "preview_encoded_png"
    t.integer "property_type_id"
    t.string "public_address"
    t.integer "reviews_count"
    t.string "room_and_property_type"
    t.string "room_type"
    t.string "room_type_category"
    t.string "scrim_color"
    t.boolean "show_structured_name"
    t.string "space_type"
    t.integer "star_rating"
    t.string "star_rating_color"
    t.integer "tier_id"
    t.bigint "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "airdna_rating"
    t.decimal "occ"
    t.decimal "airdna_longitude"
    t.decimal "airdna_latitude"
    t.decimal "adr"
    t.decimal "revenue"
    t.decimal "number_of_reviews"
    t.string "homeaway_property_id"
    t.text "airdna_neighborhood_ids", default: [], array: true
    t.text "airdna_zipcode_ids", default: [], array: true
    t.index ["adr"], name: "index_listings_on_adr"
    t.index ["airdna_latitude"], name: "index_listings_on_airdna_latitude"
    t.index ["airdna_longitude"], name: "index_listings_on_airdna_longitude"
    t.index ["homeaway_property_id"], name: "index_listings_on_homeaway_property_id"
    t.index ["host_id"], name: "index_listings_on_host_id"
    t.index ["listing_id"], name: "index_listings_on_listing_id"
    t.index ["localized_city"], name: "index_listings_on_localized_city"
    t.index ["localized_neighborhood"], name: "index_listings_on_localized_neighborhood"
    t.index ["number_of_reviews"], name: "index_listings_on_number_of_reviews"
    t.index ["occ"], name: "index_listings_on_occ"
    t.index ["revenue"], name: "index_listings_on_revenue"
  end

  create_table "neighborhood_search_results", force: :cascade do |t|
    t.bigint "listing_id"
    t.date "checkin"
    t.integer "items_offset"
    t.integer "page_rank"
    t.string "searched_neighborhood"
    t.datetime "taken_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkin"], name: "index_neighborhood_search_results_on_checkin"
    t.index ["items_offset"], name: "index_neighborhood_search_results_on_items_offset"
    t.index ["listing_id"], name: "index_neighborhood_search_results_on_listing_id"
    t.index ["page_rank"], name: "index_neighborhood_search_results_on_page_rank"
    t.index ["searched_neighborhood"], name: "index_neighborhood_search_results_on_searched_neighborhood"
    t.index ["taken_at"], name: "index_neighborhood_search_results_on_taken_at"
  end

  create_table "price_items", force: :cascade do |t|
    t.integer "line_item_type"
    t.string "localized_explanation"
    t.string "localized_title"
    t.decimal "amount"
    t.string "currency"
    t.bigint "pricing_quote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_quote_id"], name: "index_price_items_on_pricing_quote_id"
  end

  create_table "pricing_quotes", force: :cascade do |t|
    t.date "checkin"
    t.boolean "can_instant_book"
    t.decimal "monthly_price_factor"
    t.string "price_string"
    t.decimal "rate_amount"
    t.decimal "rate_currency"
    t.string "rate_type"
    t.decimal "rate_with_service_fee_amount"
    t.string "rate_with_service_fee_currency"
    t.boolean "should_show_from_label"
    t.decimal "weekly_price_factor"
    t.bigint "listing_id"
    t.bigint "neighborhood_search_result_id"
    t.datetime "taken_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkin"], name: "index_pricing_quotes_on_checkin"
    t.index ["listing_id"], name: "index_pricing_quotes_on_listing_id"
    t.index ["neighborhood_search_result_id"], name: "index_pricing_quotes_on_neighborhood_search_result_id"
    t.index ["taken_at"], name: "index_pricing_quotes_on_taken_at"
  end

  add_foreign_key "booking_dates", "listings"
  add_foreign_key "listings", "hosts"
  add_foreign_key "neighborhood_search_results", "listings"
  add_foreign_key "price_items", "pricing_quotes"
  add_foreign_key "pricing_quotes", "listings"
  add_foreign_key "pricing_quotes", "neighborhood_search_results"
end
