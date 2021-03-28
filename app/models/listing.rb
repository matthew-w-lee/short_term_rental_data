class Listing < ApplicationRecord
  require 'csv'

  belongs_to :host
  has_many :neighborhood_search_results
  has_many :pricing_quotes
  validates :listing_id, presence: true, uniqueness: true

  scope :revenue_lte, -> (amount) {where("revenue <= ?", amount)}
  scope :revenue_gte, -> (amount) {where("revenue <= ?", amount)}
  scope :revenue_greater_than, -> (amount) {where("revenue > ?", amount)}
  scope :revenue_less_than, -> (amount) {where("revenue < ?", amount)}
  scope :hosted_by, -> (host_id) {where(host_id: host_id)}

  def self.to_csv
    headers = ["listing_id", "listing_name", "neighborhood", "bedrooms", "host_url", "listing_url", "revenue", "occ", "adr", "airdna_lat", "airdna_long", "host_id"]
    CSV.open("csv_export_listings.csv", "w") do |csv|
      csv << headers
      Listing.includes(:host).find_each do |row|
        csv << [row.listing_id, row.name, row.localized_neighborhood, row.bedrooms, row.host.airbnb_url, row.airbnb_url, row.revenue, row.occ, row.adr, row.airdna_latitude, row.airdna_longitude, row.host_id]
      end
    end
  end

  def checkin_dates
  	self.neighborhood_search_results.order(:checkin).distinct.pluck(:checkin)
  end

  def airbnb_url
  	"https://www.airbnb.com/rooms/#{self.listing_id}"
  end

  def pricing_quote_by_checkin(date)
  	h = {}
  	self.pricing_quotes.where(checkin: date).order(:taken_at).each do |p|
  		h[p.taken_at.strftime("%m-%d-%Y")] = p.total.to_s
  	end
  	h
  end

  def all_pricing_quotes_by_checkin
  	self.checkin_dates.map {|f| self.pricing_quote_by_checkin(f)}
  end

  def calendar_snapshot(taken_date)
  	self.checkin_dates.map {|f| [f, ]}
  end

end
