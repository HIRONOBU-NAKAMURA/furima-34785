require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    before do
      @user = FactoryBot.build(:user)
    end
    context 'ユーザーの新規登録ができるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation,first_name, last_name, kana_first_name,kana_last_name,birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '1a1a1a1a'
        @user.password_confirmation = '1a1a1a1a'
        expect(@user).to be_valid
      end
    end

    context 'ユーザーの新規登録ができないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@がないと登録できないこと' do
        @user.email = 'example.gmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字以上でないと登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードに英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードに数字のみでは登録できないこと' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードに全角では登録できないこと' do
        @user.password = '１２３４５６'
        @user.password_confirmation = '１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードは、確認を含めて2回入力しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード（確認用）は、値の一致がしていないと登録できない' do
        @user.password_confirmation = 'example101'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      #本人確認情報
      it '名字が空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前が空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
      @user.last_name = 'nakamura'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it '名前は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
      @user.first_name = 'hironobu'
      @user.valid?
      expect(@user.errors.full_messages).to include( "First name is invalid")
      end
      it '名字（フリガナ）が空だと登録できない' do
      @user.kana_last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it '名前（フリガナ）が空だと登録できない' do
      @user.kana_first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'ユーザーの名字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.kana_last_name = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana last name is invalid")
      end
      it 'ユーザーの名字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.kana_first_name = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana first name is invalid")
      end
      it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
