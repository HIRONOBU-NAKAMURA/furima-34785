require 'rails_helper'

RSpec.describe 'トップページ', type: :system do
  describe 'トップページ' do
    it 'ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されること' do
      visit root_path
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end

    it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること' do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
      expect(current_path).to eq(new_user_session_path)
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end

    it 'ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できること' do
      visit root_path
      click_on('新規登録')
      expect(current_path).to eq(new_user_registration_path)
      visit root_path
      click_on('ログイン')
      expect(current_path).to eq(new_user_session_path)
    end

    it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトできること' do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
      expect(current_path).to eq(new_user_session_path)
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      expect(page).to have_content('ログアウト')
      click_on('ログアウト')
      expect(current_path).to eq(root_path)
    end
  end
end
