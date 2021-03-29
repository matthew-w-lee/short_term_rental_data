require 'csv'

class ListingCalendarParser

	def calendar_file(filename)
		ListingCalendarFile.new(f_name)
	end

	def load_db
		Dir.glob('/scrape_results/listing/*.csv') do |f|
			file = ListingCalendarFile.new(f)
			file.save_to_db
		end
	end


end

class ListingCalendarFile

	def initialize(filename)
		@file_data = parse_csv_file(filename)
		temp_data = @file_data.map {|f| Row.new(f)}
		temp_data.shift
		@rows = temp_data
	end

	def save_to_db
		rows.each do |row|
			row.booking_dates.each do |b|
				BookingDate.create(b)
			end
		end
	end

	def rows
		@rows
	end

	def yo
		@rows.map {|f| [f.listing_id, f.rate_for_dates(Date.new(2019, 8, 9), 3)]}
	end


	def parse_csv_file(filename)
		new_arr = []
		CSV.foreach(filename, headers:true) do |h|
			new_arr << h.to_hash
		end
		new_arr
	end

end

class Row

	def initialize(hash)
		@hash = hash
		@days = days
		@condition_ranges = condition_ranges
	end

	def hash
		@hash
	end

	def listing_id
		@hash["listing_id"]
	end

	def listing
		Listing.where(listing_id: listing_id).first
	end

	def rate_for_dates(checkin, num_of_nights)
		rate_total = 0
		checkout = checkin + (num_of_nights - 1).days
		(checkin..checkout).each do |day|
			found_date = days.detect {|f| f.date == day}
			if found_date
				rate_total = rate_total + found_date.rate
			end
		end
		rate_total
	end

	def find_date(date)
		days.detect {|f| f.date == date}
	end

	def booking_dates
		h = booking_date_data_for_row
		@days.map do |day|
			day_date = day.hash['date']
			h[:conditions_json] = @condition_ranges.detect {|c| c.start_date == day_date}.hash.to_json
			h.merge(day.hash)
		end
	end

	def booking_date_data_for_row
		{
			dynamic_pricing_updated_at: @hash["dynamic_pricing_updated_at"],
#			conditions: parse_conditions,
			listing_id: listing.id,
			taken_at: @hash['taken_at'],
#			calendar_date: @hash['date'],
#			available: @hash[''],
#			available_for_checkin: @hash[''], 
#			max_nights: @hash[''], 
#			min_nights: @hash[''],
#			price: parse_string
		}
	end

	def days
		@hash.select {|k,v| k.split("___")[0] == 'days' unless k.nil?}.group_by {|k,v| k.split("___")[1]}.values.map {|f| CalendarDay.new(f)}
	end

	def condition_ranges
		@hash.select {|k,v| k.split("___")[0] == 'condition_ranges' unless k.nil?}.group_by {|k,v| k.split("___")[1]}.values.map {|f| ConditionRange.new(f)}
	end


end

class ConditionRange

	def initialize(arr)
		@arr=arr
		@hash = parse_arr(arr)
	end

	def hash
		@hash
	end

	def start_date
		@hash['start_date']
	end

	def parse_arr(arr)
		h = {}
		h['conditions'] = parse_conditions(arr)
		arr.reject {|f| f[0].split("___")[2] == 'conditions'}.each do |item|
			h[item[0].split("___")[2]] = item[1]
		end
		h
	end

	def parse_conditions(arr)
		h = {}
		arr.select {|f| f[0].split("___")[2] == 'conditions'}.each do |item|
			h[item[0].split("___")[3]] = item[1]
		end
		h.to_json
	end

end


class CalendarDay

	def initialize(arr)
		@arr = arr
		@hash = parse_arr(arr)
	end

	def hash
		@hash
	end

	def rate
		begin
			JSON.parse(@hash['price'])['local_price'].to_d
		rescue NoMethodError
			return nil
		end
	end

	def date
		Date.strptime(@hash['date'], '%Y-%m-%d') unless @hash['date'].nil?
	end

	def p_type
		@arr.detect {|f| f[0].include?("___type") }[1]
	end

	def parse_arr(arr)
		h = {}
		h['price_json'] = parse_price_items(arr)
		price_items = JSON.parse(h['price_json'])
		h['local_price'] = price_items['local_price'].to_d if price_items['local_price']
		h['local_adjusted_price'] = price_items['local_adjusted_price'].to_d if price_items['local_adjusted_price']
		arr.reject {|f| f[0].split("___")[2] == 'price'}.each do |item|
			h[item[0].split("___")[2]] = item[1]
		end
		h
	end

	def parse_price_items(arr)
		h = {}
		arr.select {|f| f[0].split("___")[2] == 'price'}.each do |item|
			h[item[0].split("___")[3]] = item[1]
		end
		h.to_json
	end
end