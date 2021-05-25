class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :postal_code, null: false
      t.integer :shipping_area_id, null: false
      t.string :town, null: false
      t.string :address, null: false
      t.string :building
      t.string :tel, null: false
      t.references :buy, foreign_keys: true
      t.timestamps
    end
  end
end
