class BuyArea
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :shipping_area_id, :town, :address, :tel, :building, :token
  
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :town
    validates :address
    validates :tel, length: { maximum: 11 }
    validates :shipping_area_id, numericality: {other_than: 1 }
    validates :user_id
    validates :item_id
    validates :token
  end

  
  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Area.create(postal_code: postal_code, shipping_area_id: shipping_area_id, town: town, address: address, tel: tel, building: building, buy_id: buy.id)
  end
end