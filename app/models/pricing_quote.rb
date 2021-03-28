class PricingQuote < ApplicationRecord
  require 'csv'
  belongs_to :listing
  belongs_to :neighborhood_search_result
  has_many :price_items

  scope :taken_before, -> (date) {where("taken_at < ?", date.to_datetime)}
  scope :taken_after, -> (date) {where("taken_at >= ?", date.to_datetime)}
  scope :taken_on, -> (date) {taken_before(date + 1.day).taken_after(date)}

  def self.to_csv
  	headers = ["taken_at", "checkin", "listing_id", "listing_name", "neighborhood", "bedrooms", "host_url", "listing_url", "total", "revenue", "occ", "adr", "airdna_lat", "airdna_long", "host_id"]
  	CSV.open("csv_export_1.csv", "w") do |csv|
  		csv << headers
  		PricingQuote.includes({listing: :host}, :price_items).where(price_items: {localized_title: "Total"}).find_each do |row|
  			csv << [row.taken_at, row.checkin, row.listing.listing_id, row.listing.name, row.listing.localized_neighborhood, row.listing.bedrooms, row.listing.airbnb_url, row.listing.host.airbnb_url, row.price_items.first.amount, row.listing.revenue, row.listing.occ, row.listing.adr, row.listing.airdna_latitude, row.listing.airdna_longitude, row.listing.host_id]
  		end
  	end
  end

  def self.all_checkin_dates
  	PricingQuote.distinct.pluck(:checkin)
  end

  def total
  	self.price_items.where(localized_title: "Total").first.amount
  end

  def cleaning_fee
  	self.price_items.where(line_item_type: 5).first.amount
  end

  def service_fee
  	self.price_items.where(line_item_type: 4).first.amount
  end

  def rate_line_item
    self.price_items.where(line_item_type: 2).first
  end

  def rate_per_night
  	self.price_items.where(line_item_type: 2).first.localized_title[/\$[0-9,]+/][/[0-9,]+/].to_d
  end

  def date_ranges_by_day(start_date, end_date)
  	(start_date..end_date).map {|date| date.to_time.to_datetime..(date.to_time + 24.hours).to_datetime}
  end

end
