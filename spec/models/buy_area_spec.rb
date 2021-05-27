require 'rails_helper'

RSpec.describe BuyArea, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @buy_area = FactoryBot.build(:buy_area, user_id: user.id, item_id: item.id)
      sleep 0.1 
    end

    context '商品の購入ができる' do
      it '必須項目に正しい入力がされていれば商品の購入ができる' do
        expect(@buy_area).to be_valid
      end
      it '建物名に入力がなくても商品の購入ができる' do
        @buy_area.building = ''
        expect(@buy_area).to be_valid
      end
    end

    context '商品の購入ができない' do
      it 'クレジットカード情報が正しく入力できていないと商品の購入ができない' do
        @buy_area.token = ''
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では商品の購入ができない' do
        @buy_area.postal_code = ''
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にはハイフン(-)が含まれていないと登録できない' do
        @buy_area.postal_code = '1234567'
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が空(1)では商品の購入ができない' do
        @buy_area.shipping_area_id = 1
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Shipping area must be other than 1")
      end
      it '市区町村が空では商品の購入ができない' do
        @buy_area.town = ''
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Town can't be blank")
      end
      it '番地情報が空では商品の購入ができない' do
        @buy_area.address = ''
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では商品の購入ができない' do
        @buy_area.tel = ''
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号が11文字以上では登録できない' do
        @buy_area.tel = '090123456789'
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Tel is too long (maximum is 11 characters)")
      end
      it '電話番号が英数混合である場合、登録できない' do
        @buy_area.tel = '090abcd5678'
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Tel is invalid")
      end
      it '購入する商品に紐づくユーザーが存在しない場合、商品の購入ができない' do
        @buy_area.user_id = nil
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("User can't be blank")
      end
      it '購入する商品が存在しない場合、商品の購入ができない' do
        @buy_area.item_id = nil
        @buy_area.valid?
        expect(@buy_area.errors.full_messages).to include("Item can't be blank")
      end
    end

  end
  
end
 