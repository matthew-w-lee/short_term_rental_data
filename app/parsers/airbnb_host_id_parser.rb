class AirbnbHostIdParser
require 'csv'

	def initialize
		@csv = CSV.read('data.csv')
		@data = @csv.reject {|f| f[1].nil?}
	end

	def rows
		@data.map {|f| HostRow.new(f)}
	end



end

class HostRow

	def initialize(data)
		@data = data
	end

	def data
		@data
	end

	def update_host
		h = Host.find_or_create_by(host_id: host_id)
		h.update(first_name: host_name)
	end

	def to_h
		{
			listing_id: listing_id,
			host_id: host_id,
			first_name: host_name
		}
	end

	def listing_id
		@data[0][/[0-9]+/]
	end

	def host_id
		@data[0][/[0-9]+/]
	end

	def host_name
		@data[2].remove(" User Profile")
	end

end