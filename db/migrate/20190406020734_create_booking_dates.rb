class CreateBookingDates < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_dates do |t|
      t.string :dynamic_pricing_updated_at
      t.text :conditions_json
      t.references :listing, foreign_key: true
      t.datetime :taken_at
      t.date :date
      t.boolean :available
      t.boolean :available_for_checkin
      t.integer :max_nights
      t.integer :min_nights
      t.text :price_json
      t.decimal :local_price
      t.decimal :local_adjusted_price
      t.timestamps
    end
    add_index :booking_dates, :taken_at
    add_index :booking_dates, :date
    add_index :booking_dates, :available
    add_index :booking_dates, :available_for_checkin
    add_index :booking_dates, :min_nights
    add_index :booking_dates, :local_price
  end
end
