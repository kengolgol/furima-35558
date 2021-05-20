require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる' do
      it '全ての必須項目に正しい情報が存在すればユーザー新規登録ができる' do
        expect(@user).to be_valid
      end
      it 'last_nameに全角（漢字・ひらがな・カタカナ）での入力が存在すれば登録できる' do
        @user.last_name = '佐さキ'
        expect(@user).to be_valid
      end
      it 'first_nameに全角（漢字・ひらがな・カタカナ）での入力が存在すれば登録できる' do
        @user.first_name = '小じロウ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaに全角（カタカナ）での入力が存在すれば登録できる' do
        @user.last_name_kana = 'ササキ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaに全角（カタカナ）での入力が存在すれば登録できる' do
        @user.first_name_kana = 'コジロウ'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationに６文字以上かつ、半角英数字が混合された入力がされていれば登録できる' do
        @user.password = 'sasa33'
        @user.password_confirmation = 'sasa33'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない' do
      it 'nicknameが空であれば登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空であれば登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'すでに登録されているemailでは登録できない' do
        @user.email = 'test@test.com'
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = 'test@test.com'
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it '@を含まないemailでは登録できない' do
        @user.email = 'test.test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空であれば登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空であれば登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationの値が一致していないければ登録できない' do
        @user.password = 'sasaki33'
        @user.password_confirmation = 'miyamoto66'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationに６文字以上だが、半角英数字が混合されていない入力が存在すると登録できない' do
        @user.password = 'sasaki'
        @user.password_confirmation = 'sasaki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordとpassword_confirmationが6文字未満の値であれば登録できない。' do
        @user.password = 'sasa3'
        @user.password_confirmation = 'sasa3'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが全角の場合は登録できない' do
        @user.password = 'ｓａｓａｋｉ３３'
        @user.password_confirmation = 'ｓａｓａｋｉ３３'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'last_nameが空であれば登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameに全角（漢字・ひらがな・カタカナ）以外の入力が存在すると登録できない' do
        @user.last_name = 'sasaki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'first_nameが空であれば登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameに全角（漢字・ひらがな・カタカナ）以外の入力が存在すると登録できない' do
        @user.first_name = 'kozirou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'last_name_kanaが空であれば登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaに全角（カタカナ）以外の入力が存在すると登録できない' do
        @user.last_name_kana = '佐々木'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'first_name_kanaが空であれば登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaに全角（カタカナ）以外の入力が存在すると登録できない' do
        @user.first_name_kana = '小次郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it 'birthdayが空であれば登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
