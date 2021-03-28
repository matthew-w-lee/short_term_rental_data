class RemoveWideKickerContentFromHosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :hosts, :wide_kicker_content, :string
  end
end
