require 'rails_helper'

RSpec.describe DonationAddress, type: :model do
  describe '商品出品機能' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @donation_address = FactoryBot.build(:donation_address,item_id: item.id, user_id: user.id)
      sleep(1)
    end

    context '商品を購入できるとき' do
      it 'postal_code,:shipping_address,:city,:address_number,:building_name,:phone_numberが存在すれば登録できる' do
        expect(@donation_address).to be_valid
      end
    end

    context '商品を購入できないとき' do
      it '郵便番号が存在していないと登録できないこと' do
        @donation_address.postal_code = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと登録できないこと' do
        @donation_address.postal_code = '1234567'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '都道府県が存在していないと登録できないこと' do
        @donation_address.prefecture = 0
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が存在しないと登録できないこと' do
        @donation_address.city = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が登録されていないと登録できないこと' do
        @donation_address.address_number = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Address number can't be blank")
      end

      it '電話番号が記述されていないと登録できないこと' do
        @donation_address.phone_number = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は11桁より大きい数字では登録できないこと' do
        @donation_address.phone_number = '123456789101'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end

  end
end
