class AddShippingAreaIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :shipping_area_id, :integer
  end
end
