require 'rails_helper'

describe '一覧画面のテスト' do
	let!(:user_paid) { create(:user, :paid) }
  let!(:user_free) { create(:user, :free) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_admin2) { create(:user, :admin) }
  context '表示の確認(講師がログイン)' do
  	before do
  		visit new_user_session_path 
  		fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit users_path
    end
    it '「会員一覧」と表示される' do
      expect(page).to have_content('会員一覧')
    end
    it '自分と講師が表示されない' do
      expect(page).to have_no_content user_admin.name
      expect(page).to have_no_content user_admin2.name
    end
    it '有料会員と無料会員の会員ステータスが表示される' do
      expect(page).to have_content user_paid.status
      expect(page).to have_content user_free.status
    end
    it '有料会員と無料会員の氏名が表示される' do
      expect(page).to have_link user_paid.name, href: user_path(user_paid)
      expect(page).to have_link user_free.name, href: user_path(user_free)
    end
    it '有料会員と無料会員の有効/退会が表示される' do
      expect(page).to have_content '有効'
    end
    it '支払い情報リンクが表示される' do
      expect(page).to have_link '支払い情報へ', href: user_payments_path(user_paid)
      expect(page).to have_link '支払い情報へ', href: user_payments_path(user_free)
    end
  end

  context '有料会員画面遷移の確認' do
    before do
      visit new_user_session_path 
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
      visit users_path
    end
    it '画面遷移できない' do
      expect(current_path).to eq(user_path(user_paid))
    end
  end

  context '無料会員画面遷移の確認' do
    before do
      visit new_user_session_path 
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
      visit users_path
    end
    it '画面遷移できない' do
      expect(current_path).to eq(user_path(user_free))
    end
  end
end

describe 'ページネーション表示テスト' do
  let(:user_admin3) { create(:user, :admin) }
  context 'ページネーションの確認(講師がログイン)' do
    before do
      create_list(:user, 11, :paid)
      visit new_user_session_path 
      fill_in 'user[email]', with: user_admin3.email
      fill_in 'user[password]', with: user_admin3.password
      click_button 'ログインする'
      visit users_path
    end
    it 'ページネーションが表示される' do
      expect(page).to have_css '.pagination'
    end
  end
end