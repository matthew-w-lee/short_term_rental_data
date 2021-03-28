class CreateNeighborhoodSearchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :neighborhood_search_results do |t|
      t.references :listing, foreign_key: true
      t.date :checkin
      t.integer :items_offset
      t.integer :page_rank
      t.string :searched_neighborhood
      t.datetime :taken_at

      t.timestamps
    end
    add_index :neighborhood_search_results, :checkin
    add_index :neighborhood_search_results, :items_offset
    add_index :neighborhood_search_results, :page_rank
    add_index :neighborhood_search_results, :searched_neighborhood
    add_index :neighborhood_search_results, :taken_at
  end
end
