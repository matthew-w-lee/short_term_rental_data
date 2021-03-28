class CreateHosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hosts do |t|
      t.string :first_name
      t.boolean :has_profile_pic
      t.integer :host_id
      t.boolean :is_superhost
      t.string :picture_url
      t.string :smart_name
      t.string :thumbnail_url
      t.string :wide_kicker_content

      t.timestamps
    end
    add_index :hosts, :host_id
    add_index :hosts, :first_name
  end
end
