class RemoveAreaFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :area_id, :integer
  end
end
