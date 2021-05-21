require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる' do
      it '必須項目に正しい情報が入力されていれば商品の出品ができる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない' do
      it '商品画像が空の場合、商品の出品ができない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空の場合、商品の出品ができない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空の場合、商品の出品ができない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'カテゴリーの情報が1の場合、商品の出品ができない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態についての情報が1の場合、商品の出品ができない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it '配送料の負担についての情報が1の場合、商品の出品ができない' do
        @item.delivery_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
      end
      it '発送元の地域についての情報が1の場合、商品の出品ができない' do
        @item.area_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Area must be other than 1")
      end
      it '発送までの日数についての情報が1の場合、商品の出品ができない' do
        @item.day_to_ship_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship must be other than 1")
      end
      it '販売価格についての情報が空の場合、商品の出品ができない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が¥300未満の場合、商品の出品ができない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
      end
      it '販売価格が¥10000000以上の場合、商品の出品ができない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 1000000")
      end
      it '販売価格が全角数字の場合に保存できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'ユーザーが紐づいていない商品は出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

