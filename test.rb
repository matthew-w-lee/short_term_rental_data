require 'csv'
class CsvFile

	def initialize(filename)
		@filename = filename
		@file_data = parse_csv_file(filename)
	end

	def parse_csv_file(filename)
		keys = CSV.read(filename)[0]
		CSV.read(filename).map {|a| Hash[keys.zip(a)]}
	end

end

class CsvRow
	def initialize(data)
		@data = data
	end

end

class Cell
	def initialize(c_name, value)
		@name = c_name
		@name_list = split_name(c_name)
		@value = value
	end

	def split_name(c_name)
		if c_name.nil?
			[nil]
		else
			c_name.split("___")
		end
	end

	def is_host_language
		@name_list[1] == 'host_languages'
	end

end

host = {
  first_name: row['listing___user___first_name'],
  host_id: row['listing___user___id'],
  has_profile_pic: row['listing___user___has_profile_pic'],
  is_superhost: row['listing___user___is_superhost'],
  picture_url: row['listing___user___picture_url'],
  smart_name: row['listing___user___smart_name'],
  thumbnail_url: row['listing___user___thumbnail_url']
}

listing = {
	amenity_ids: row[''],
    avg_rating: row['listing___avg_rating'],
    badges: row[''],
    bathroom_label: row['listing___bathroom_label'],
    bathrooms: row['listing___bathrooms'],
    bed_label: row['listing___bed_label'],
    bedroom_label: row['listing___bedroom_label'],
    bedrooms: row['listing___bedrooms'],
    beds: row['listing___beds'],
    city: row['listing___city'],
    guest_label: row['listing___guest_label'],
    host_languages: row[''],
    host_thumbnail_url_small: row['listing___host_thumbnail_url_small'],
    host_thumbnail_url: row['listing___host_thumbnail_url'],
    listing_id: row['listing___id'],
    is_business_travel_ready: row['listing___is_business_travel_ready'],
    is_fully_refundable: row['listing___is_fully_refundable'],
    is_host_highly_rated: row['listing___is_host_highly_rated'],
    is_new_listing: row['listing___is_new_listing'],
    is_superhost: row['listing___is_superhost'],
    kicker_content: row[''],
    lat: row['listing___lat'],
    lng: row['listing___lng'],
    localized_city: row['listing___localized_city'],
    localized_neighborhood: row['listing___localized_neighborhood'],
    main_section_message: row[''],
    name: row['listing___name'],
    neighborhood: row['listing___neighborhood'],
    person_capacity: row['listing___person_capacity'],
    picture: row[''],
    picture_count: row['listing___picture_count'],
    picture_url: row['listing___picture_url'],
    picture_urls: row[''],
    preview_amenities: row['listing___preview_amenities'],
    preview_amenity_names: row[''],
    preview_encoded_png: row[''],
    property_type_id: row['listing___property_type_id'],
    public_address: row['listing___public_address'],
    reviews_count: row['listing___reviews_count'],
    room_and_property_type: row['listing___room_and_property_type'],
    room_type: row['listing___room_type'],
    room_type_category: row['listing___room_type_category'],
    scrim_color: row['listing___scrim_color'],
    show_structured_name: row['listing___show_structured_name'],
    space_type: row['listing___space_type'],
    star_rating: row['listing___star_rating'],
    star_rating_color: row['listing___star_rating_color'],
    tier_id: row['listing___tier_id'],
    host_id: row['']
}

def parse_host_languages(array)

end
listing___host_languages___0,
listing___host_languages___1,
listing___host_languages___2,listing___host_languages___3,listing___host_languages___4,

listing___kicker_content___kicker_badge___label,
isting___kicker_content___kicker_badge___type,
listing___kicker_content___messages___0,
listing___kicker_content___messages___1,
listing___kicker_content___text_color,

listing___main_section_message___body,
listing___main_section_message___headline,
listing___main_section_message___icon_type,listing___main_section_message___type,

listing___picture___dominant_saturated_color,
listing___picture___id,
listing___picture___large_ro,
listing___picture___picture,
listing___picture___preview_encoded_png,
listing___picture___saturated_a11y_dark_color,
listing___picture___scrim_color,

listing___picture_urls___0,
listing___picture_urls___1,listing___picture_urls___10,listing___picture_urls___11,listing___picture_urls___12,listing___picture_urls___13,listing___picture_urls___14,listing___picture_urls___15,listing___picture_urls___16,listing___picture_urls___17,listing___picture_urls___18,listing___picture_urls___19,listing___picture_urls___2,listing___picture_urls___20,listing___picture_urls___21,listing___picture_urls___22,listing___picture_urls___23,listing___picture_urls___24,listing___picture_urls___25,listing___picture_urls___26,listing___picture_urls___27,listing___picture_urls___28,listing___picture_urls___29,listing___picture_urls___3,listing___picture_urls___4,listing___picture_urls___5,listing___picture_urls___6,listing___picture_urls___7,listing___picture_urls___8,listing___picture_urls___9,

listing___preview_amenity_names___0,
listing___preview_amenity_names___1,
listing___preview_amenity_names___2,listing___preview_amenity_names___3,listing___preview_encoded_png,


listing___amenity_ids___0,listing___amenity_ids___1,listing___amenity_ids___10,listing___amenity_ids___11,listing___amenity_ids___12,listing___amenity_ids___13,listing___amenity_ids___14,listing___amenity_ids___15,listing___amenity_ids___16,listing___amenity_ids___17,listing___amenity_ids___18,listing___amenity_ids___19,listing___amenity_ids___2,listing___amenity_ids___20,listing___amenity_ids___21,listing___amenity_ids___22,listing___amenity_ids___23,listing___amenity_ids___24,listing___amenity_ids___25,listing___amenity_ids___26,listing___amenity_ids___27,listing___amenity_ids___28,listing___amenity_ids___29,listing___amenity_ids___3,listing___amenity_ids___30,listing___amenity_ids___31,listing___amenity_ids___32,listing___amenity_ids___33,listing___amenity_ids___34,listing___amenity_ids___35,listing___amenity_ids___36,listing___amenity_ids___37,listing___amenity_ids___38,listing___amenity_ids___39,listing___amenity_ids___4,listing___amenity_ids___40,listing___amenity_ids___41,listing___amenity_ids___42,listing___amenity_ids___43,listing___amenity_ids___44,listing___amenity_ids___45,listing___amenity_ids___46,listing___amenity_ids___47,listing___amenity_ids___48,listing___amenity_ids___49,listing___amenity_ids___5,listing___amenity_ids___50,listing___amenity_ids___51,listing___amenity_ids___52,listing___amenity_ids___53,listing___amenity_ids___54,listing___amenity_ids___55,listing___amenity_ids___56,listing___amenity_ids___57,listing___amenity_ids___58,listing___amenity_ids___59,listing___amenity_ids___6,listing___amenity_ids___60,listing___amenity_ids___61,listing___amenity_ids___62,listing___amenity_ids___63,listing___amenity_ids___64,listing___amenity_ids___7,listing___amenity_ids___8,listing___amenity_ids___9,
,
listing___badges___0,




['checkin'],
items_offset,

page_rank,pricing_quote___can_instant_book,pricing_quote___monthly_price_factor,pricing_quote___price___localized_title,pricing_quote___price___price_items___0___line_item_type,pricing_quote___price___price_items___0___localized_explanation,pricing_quote___price___price_items___0___localized_title,pricing_quote___price___price_items___0___total___amount,pricing_quote___price___price_items___0___total___amount_formatted,pricing_quote___price___price_items___0___total___currency,pricing_quote___price___price_items___0___total___is_micros_accuracy,pricing_quote___price___price_items___1___line_item_type,pricing_quote___price___price_items___1___localized_explanation,pricing_quote___price___price_items___1___localized_title,pricing_quote___price___price_items___1___total___amount,pricing_quote___price___price_items___1___total___amount_formatted,pricing_quote___price___price_items___1___total___currency,pricing_quote___price___price_items___1___total___is_micros_accuracy,pricing_quote___price___price_items___2___line_item_type,pricing_quote___price___price_items___2___localized_explanation,pricing_quote___price___price_items___2___localized_title,pricing_quote___price___price_items___2___total___amount,pricing_quote___price___price_items___2___total___amount_formatted,pricing_quote___price___price_items___2___total___currency,pricing_quote___price___price_items___2___total___is_micros_accuracy,pricing_quote___price___total___amount,pricing_quote___price___total___amount_formatted,pricing_quote___price___total___currency,pricing_quote___price___total___is_micros_accuracy,pricing_quote___price_string,pricing_quote___rate___amount,pricing_quote___rate___amount_formatted,pricing_quote___rate___currency,pricing_quote___rate___is_micros_accuracy,pricing_quote___rate_type,pricing_quote___rate_with_service_fee___amount,pricing_quote___rate_with_service_fee___amount_formatted,pricing_quote___rate_with_service_fee___currency,pricing_quote___rate_with_service_fee___is_micros_accuracy,pricing_quote___should_show_from_label,pricing_quote___weekly_price_factor,searched_neighborhood,taken_at,verified___badge_secondary_text,verified___badge_text,verified___enabled,verified___kicker_badge_type,verified_card