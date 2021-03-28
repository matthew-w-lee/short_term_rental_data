class Host < ApplicationRecord
	has_many :listings
	validates :host_id, presence: true, uniqueness: true

	def airbnb_url
		"https://www.airbnb.com/users/show/#{self.host_id}"
	end

end
