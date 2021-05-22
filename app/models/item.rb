class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :area
  belongs_to :day_to_ship

  belongs_to :user

  with_options presence: true do
    validates :name
    validates :content
    validates :image
    
    with_options numericality: {other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :delivery_charge_id
      validates :area_id
      validates :day_to_ship_id
    end

    with_options numericality: {greater_than: 299, less_than: 10000000} do
      validates :price
    end

  end

end
