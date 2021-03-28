class CreatePricingQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_quotes do |t|
      t.date :checkin
      t.boolean :can_instant_book
      t.decimal :monthly_price_factor
      t.string :price_string
      t.decimal :rate_amount
      t.decimal :rate_currency
      t.string :rate_type
      t.decimal :rate_with_service_fee_amount
      t.string :rate_with_service_fee_currency
      t.boolean :should_show_from_label
      t.decimal :weekly_price_factor
      t.references :listing, foreign_key: true
      t.references :neighborhood_search_result, foreign_key: true
      t.datetime :taken_at

      t.timestamps
    end
    add_index :pricing_quotes, :checkin
    add_index :pricing_quotes, :taken_at
  end
end
