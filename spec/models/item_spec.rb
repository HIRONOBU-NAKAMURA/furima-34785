require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end
    context '商品の出品ができるとき' do
      it 'title,description,category_id,status_id,shipping_change_id,shipping_address_id,day_id,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができないとき' do
      it '商品画像がないと登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと登録できないこと' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品の説明がないと登録できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報がないと登録できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end

      it '商品の状態についての情報がないと登録できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Status is not a number')
      end

      it '配送料の負担についての情報がないと登録できないこと' do
        @item.shipping_change_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping change is not a number')
      end

      it '発送元の地域についての情報がないと登録できないこと' do
        @item.shipping_address_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping address is not a number')
      end

      it '発送までの日数についての情報がないと登録できないこと' do
        @item.day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Day is not a number')
      end
      it '販売価格についての情報がないと登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が300円未満だと登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 300')
      end

      it '販売価格が1,000,000円以上だと登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 9999999')
      end

      it '販売価格が半角数字意外だと登録できないこと' do
        @item.price = '２２２２２'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格が半角英数混合では登録できないこと' do
        @item.price = '1a1a1a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格が英語だけでは登録できないこと' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
