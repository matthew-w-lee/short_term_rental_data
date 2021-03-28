class CreatePriceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :price_items do |t|
      t.integer :line_item_type
      t.string :localized_explanation
      t.string :localized_title
      t.decimal :amount
      t.string :currency
      t.references :pricing_quote, foreign_key: true

      t.timestamps
    end
  end
end
