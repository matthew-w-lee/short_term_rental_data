class AirdnaPropertyList
	def initialize(filename)
		@json = JSON.parse(File.open(filename).read)
	end

	def json
		@json
	end

	def properties
		@json['properties'].map {|f| Property.new(f).property_hash}
	end

	def parse
		properties.each do |prop|
			l = Listing.where(listing_id: prop[:listing_id]).take
			if l.present?
				l.update(prop)
			else
				h = Host.where(host_id: 99999999).take
				h.listings.create(prop)
			end
		end
	end


end

class Property

	def initialize(json)
		@json = json
	end

	def property_hash
		{
			listing_id: @json['airbnb_property_id'],
			bathrooms: @json['bathrooms'],
			room_type: @json['room_type'],
			person_capacity: @json['accommodates'],
			bedrooms: @json['bedrooms'],
			airdna_rating: @json['rating'],
			occ: @json['occ'],
			airdna_longitude: @json['longitude'],
			airdna_latitude: @json['latitude'],
			adr: @json['adr'],
			revenue: @json['revenue'],
			number_of_reviews: @json['reviews'],
			homeaway_property_id: @json['homeaway_property_id'],
			airdna_neighborhood_ids: @json['regions']['neighborhood_ids'],
			localized_neighborhood: parse_neighborhood,
			airdna_zipcode_ids: @json['regions']['zipcode_ids']
		}
	end

	def parse_neighborhood
		neighborhood_ids = @json['regions']['neighborhood_ids']
		if neighborhood_ids
			puts neighborhood_ids[0]
			puts region_lookup[neighborhood_ids[0].to_s]
			return region_lookup[neighborhood_ids[0].to_s]
		else
			return nil
		end
	end

    def region_lookup
        {
            '126627'=> 'Avondale',
            '126631'=> 'Boystown',
            '126632'=> 'Bridgeport',
            '126633'=> 'Brighton Park',
            '126641'=> 'East Side',
            '126643'=> 'Edison Park',
            '126644'=> 'Englewood',
            '126652'=> 'Hegewisch',
            '126634'=> 'Bronzeville',
            '126635'=> 'Bucktown',
            '126642'=> 'Edgewater',
            '126648'=> 'Garfield Park',
            '126654'=> 'Humboldt Park',
            '126655'=> 'Hyde Park',
            '126656'=> 'Irving Park',
            '126665'=> 'Logan Square',
            '126666'=> 'Loop',
            '126673'=> 'Near North Side',
            '126674'=> 'Near West Side',
            '126653'=> 'Hermosa',
            '126664'=> 'Little Village',
            '126668'=> 'Marquette Park',
            '126675'=> 'North Center',
            '126707'=> 'Wicker Park',
            '126708'=> 'Woodlawn',
            '126709'=> 'Wrigleyville',
            '126669'=> 'McKinley Park',
            '126677'=> 'North Park',
            '126692'=> 'South Chicago',
            '126693'=> 'South Deering',
            '126699'=> 'Washington Heights',
            '126701'=> 'West Elsdon',
            '126630'=> 'Beverly',
            '126646'=> 'Gage Park',
            '126657'=> 'Jackson Park',
            '126628'=> 'Back of the Yards',
            '126629'=> 'Belmont Cragin',
            '126690'=> 'Roseland',
            '126622'=> 'Archer Heights',
            '126659'=> 'Kenwood',
            '126660'=> 'Lakeview',
            '126661'=> 'Lincoln Park',
            '126662'=> 'Lincoln Square',
            '126663'=> 'Little Italy/UIC',
            '126678'=> 'Norwood Park',
            '126682'=> 'Old Town',
            '126686'=> 'River North',
            '126687'=> 'River West',
            '126688'=> 'Rogers Park',
            '126689'=> 'Roscoe Village',
            '126694'=> 'South Loop/Printers Row',
            '126696'=> 'Streeterville',
            '126697'=> 'Ukrainian Village',
            '126698'=> 'Uptown',
            '126703'=> 'West Loop/Greektown',
            '126706'=> 'West Town/Noble Square',
            '126623'=> 'Armour Square',
            '126624'=> 'Ashburn',
            '126625'=> 'Auburn Gresham',
            '126636'=> 'Calumet Heights',
            '126637'=> 'Chatham',
            '126639'=> 'Clearing',
            '126640'=> 'Dunning',
            '126638'=> 'Chinatown',
            '126649'=> 'Garfield Ridge',
            '126650'=> 'Gold Coast',
            '126651'=> 'Grand Crossing',
            '126667'=> 'Magnificent Mile',
            '126676'=> 'North Lawndale',
            '126705'=> 'West Ridge',
            '126626'=> 'Austin',
            '126658'=> 'Jefferson Park',
            '126681'=> 'Oakland',
            '126683'=> 'Pilsen',
            '126684'=> 'Portage Park',
            '126685'=> 'Pullman',
            '126695'=> 'South Shore',
            '126700'=> 'Washington Park',
            '126620'=> 'Albany Park',
            '126621'=> 'Andersonville',
            '23515'=> '60640',
            '5351'=> '60656',
            '15818'=> '60607',
            '22090'=> '60614',
            '22102'=> '60617',
            '22438'=> '60618',
            '22446'=> '60619',
            '22454'=> '60620',
            '22749'=> '60625',
            '23150'=> '60633',
            '23168'=> '60638',
            '23434'=> '60647',
            '23431'=> '60646',
            '23514'=> '60639',
            '23517'=> '60641',
            '23519'=> '60642',
            '5202'=> '60652',
            '5201'=> '60651',
            '15212'=> '60603',
            '22472'=> '60624',
            '23154'=> '60634',
            '23112'=> '60643',
            '23148'=> '60632',
            '23157'=> '60636',
            '5355'=> '60661',
            '5353'=> '60659',
            '15813'=> '60604',
            '22084'=> '60612',
            '22094'=> '60616',
            '22459'=> '60621',
            '22469'=> '60623',
            '22753'=> '60626',
            '22761'=> '60628',
            '22767'=> '60629',
            '23116'=> '60644',
            '23437'=> '60649',
            '5203'=> '60653',
            '5349'=> '60654',
            '5352'=> '60657',
            '5354'=> '60660',
            '15815'=> '60606',
            '15821'=> '60608',
            '15825'=> '60609',
            '15210'=> '60601',
            '15211'=> '60602',
            '15814'=> '60605',
            '15827'=> '60610',
            '22082'=> '60611',
            '22460'=> '60622',
            '22086'=> '60613',
            '22092'=> '60615',
            '22769'=> '60630',
            '23143'=> '60631',
            '23160'=> '60637',
            '23427'=> '60645',
            '5350'=> '60655'
        }
   	end

end
