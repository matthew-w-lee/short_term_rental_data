require 'csv'
class ScrapyCsvParser

	def csv_file(filename)
		CsvFile.new(filename)
	end

	def load_db
		Dir.glob('/scrape_results/neighborhood_search/*.csv') do |f|
			file = CsvFile.new(f)
			file.save_to_db
		end
	end

end

class CsvFile

	def initialize(filename)
		@filename = filename
		@file_data = parse_csv_file(filename)
		temp_data = @file_data.map {|f| CsvRow.new(f)}
		temp_data.shift
		@rows = temp_data
	end

	def rows
		@rows
	end

	def rate_total_data(checkin)
		new_h = {}
		@rows.select {|r| r.checkin == checkin}.each do |f|
			new_h[f.listing_id] = f.rate_total
		end
		new_h
	end

	def parse_csv_file(filename)
		keys = CSV.read(filename)[0]
		CSV.read(filename).map {|a| Hash[keys.zip(a)]}
	end

	def save_to_db
		rows.each do |row|
			host = get_host(row)
			listing = get_listing(row, host)
			neighborhood_search_result = get_neighborhood_search_result(row, listing)
			create_pricing_quote(row, neighborhood_search_result, listing)
		end
	end

	def create_pricing_quote(row, search_result, listing)
		p_data = row.pricing_quote
		p_data[:neighborhood_search_result_id] = search_result
		p_data[:listing_id] = listing
		q = PricingQuote.create(p_data)
		row.price_items.each do |i|
			q.price_items.create(i)
		end
	end

	def get_neighborhood_search_result(row, listing)
		new_h = row.neighborhood_search_result
		new_h[:listing_id] = listing
		n = NeighborhoodSearchResult.create(new_h)
		n.id
	end

	def get_listing(row, host)
		listing = Listing.where(listing_id: row.listing[:listing_id]).first
		if listing.present?
			listing.update(row.listing)
		else
			new_h = row.listing
			new_h[:host_id] = host
			listing = Listing.create(new_h)
		end
		listing.id
	end

	def get_host(row)
		h = Host.find_or_create_by(host_id: row.host[:host_id])
		h.update(row.host)
		h.id
	end

end

class CsvRow
	def initialize(data)
		@data = data
	end

	def data
		@data
	end

	def listing_id
		@data['listing___id']
	end

	def checkin
		Date.strptime(@data['checkin'], '%Y-%m-%d')
	end

	def rate_total
		price_items.detect {|f| f[:line_item_type] == "2"}[:amount].gsub("$", "").gsub(",","").to_d
	end

	def host
		{
			first_name: @data['listing___user___first_name'],
			host_id: @data['listing___user___id'],
			has_profile_pic: @data['listing___user___has_profile_pic'],
			is_superhost: @data['listing___user___is_superhost'],
			picture_url: @data['listing___user___picture_url'],
			smart_name: @data['listing___user___smart_name'],
			thumbnail_url: @data['listing___user___thumbnail_url']
		}
	end

	def listing
		{
			amenity_ids: parse_array('listing___amenity_ids___'),
		    avg_rating: @data['listing___avg_rating'],
		    badges: parse_array('listing___badges___'),
		    bathroom_label: @data['listing___bathroom_label'],
		    bathrooms: @data['listing___bathrooms'],
		    bed_label: @data['listing___bed_label'],
		    bedroom_label: @data['listing___bedroom_label'],
		    bedrooms: @data['listing___bedrooms'],
		    beds: @data['listing___beds'],
		    city: @data['listing___city'],
		    guest_label: @data['listing___guest_label'],
		    host_languages: parse_array('listing___host_languages___'),
		    host_thumbnail_url_small: @data['listing___host_thumbnail_url_small'],
		    host_thumbnail_url: @data['listing___host_thumbnail_url'],
		    listing_id: @data['listing___id'],
		    is_business_travel_ready: @data['listing___is_business_travel_ready'],
		    is_fully_refundable: @data['listing___is_fully_refundable'],
		    is_host_highly_rated: @data['listing___is_host_highly_rated'],
		    is_new_listing: @data['listing___is_new_listing'],
		    is_superhost: @data['listing___is_superhost'],
		    kicker_content: nil,
		    lat: @data['listing___lat'],
		    lng: @data['listing___lng'],
		    localized_city: @data['listing___localized_city'],
		    localized_neighborhood: @data['listing___localized_neighborhood'],
		    main_section_message: nil,
		    name: @data['listing___name'],
		    neighborhood: @data['listing___neighborhood'],
		    person_capacity: @data['listing___person_capacity'],
		    picture: nil,
		    picture_count: @data['listing___picture_count'],
		    picture_url: @data['listing___picture_url'],
		    picture_urls: parse_array('listing___picture_urls___'),
		    preview_amenities: @data['listing___preview_amenities'],
		    preview_amenity_names: @data['listing___preview_amenity_names___'],
		    preview_encoded_png: @data['listing___preview_encoded_png'],
		    property_type_id: @data['listing___property_type_id'],
		    public_address: @data['listing___public_address'],
		    reviews_count: @data['listing___reviews_count'],
		    room_and_property_type: @data['listing___room_and_property_type'],
		    room_type: @data['listing___room_type'],
		    room_type_category: @data['listing___room_type_category'],
		    scrim_color: @data['listing___scrim_color'],
		    show_structured_name: @data['listing___show_structured_name'],
		    space_type: @data['listing___space_type'],
		    star_rating: @data['listing___star_rating'],
		    star_rating_color: @data['listing___star_rating_color'],
		    tier_id: @data['listing___tier_id'],
		    host_id: @data['listing___user___id']
		}
	end

	def parse_array(field_name)
		new_array = []
		@data.each do |key, value|
			unless key.nil?
				if key.include?(field_name)
					new_array << value
				end
			end
		end
		new_array.compact.to_json
	end

	def neighborhood_search_result
		{
#			listing_id: @data['listing___id'],
			checkin: Date.strptime(@data['checkin'], '%Y-%m-%d'),
			items_offset: @data['items_offset'],
			page_rank: @data['page_rank'],
			searched_neighborhood: @data['searched_neighborhood'],
			taken_at: parse_datetime(@data['taken_at'])
		}
	end

	def parse_datetime(dt)
		begin
			DateTime.strptime(dt, "%Y-%m-%d %I-%M%p")
		rescue ArgumentError => e
			DateTime.strptime(dt, "%Y-%m-%d %H:%M:%S")
		end
	end

	def pricing_quote
		{
			checkin: Date.strptime(@data['checkin'], '%Y-%m-%d'),
			can_instant_book: @data["pricing_quote___can_instant_book"],
			monthly_price_factor: @data["pricing_quote___monthly_price_factor"],
			price_string: @data["pricing_quote___price_string"],
			rate_amount: @data["pricing_quote___rate___amount"],
			rate_currency: @data["pricing_quote___rate___currency"],
			rate_type: @data["pricing_quote___rate_type"],
			rate_with_service_fee_amount: @data["pricing_quote___rate_with_service_fee___amount"],
			rate_with_service_fee_currency: @data["pricing_quote___rate_with_service_fee___currency"],
			should_show_from_label: @data["pricing_quote___should_show_from_label"],
			weekly_price_factor: @data["pricing_quote___weekly_price_factor"],
#			listing_id: @data["listing___id"],
	#		neighborhood_search_result_id: @data[""],
			taken_at: @data["taken_at"]
		}
	end

	def price_items
		new_array = []
		@data.each do |key, value|
			unless key.nil?
				if key.include?('pricing_quote___price___price_items___')
					new_array << [key, value]
				end
			end
		end
		price_item_list = []
		new_array.group_by {|f| f[0].split("___")[3]}.each do |key, value|
			new_h = {}
			value.each do |item|
				unless item[0].nil?
					if item[0].include?('line_item_type')
						new_h[:line_item_type] = item[1]
					elsif item[0].include?('localized_explanation')
						new_h[:localized_explanation] = item[1]					
					elsif item[0].include?('localized_title')
						new_h[:localized_title] = item[1]
					elsif item[0].include?('total___amount')
						new_h[:amount] = item[1]
					elsif item[0].include?('total___currency')
						new_h[:currency] = item[1]
					end
				end
			end
			price_item_list << new_h
		end
		price_item_list << total_price_item
		price_item_list
	end

	def total_price_item
		{
			line_item_type: nil,
			localized_explanation: nil,
			localized_title: @data['pricing_quote___price___localized_title'],
			amount: @data['pricing_quote___price___total___amount'],
			currency: @data['pricing_quote___price___total___currency']	
		}
	end

end
