class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_charge_id, null: false
      t.integer :area_id, null: false
      t.integer :day_to_ship_id, null: false
      t.integer :price, null: false
      t.references :user, foreign_keys: true
      t.timestamps
    end
  end
end
