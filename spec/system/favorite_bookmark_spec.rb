require 'rails_helper'

describe 'いいね機能のテスト', :js => true do
  let!(:user) { create(:user, :paid) }
  let!(:genre) { create(:genre, :active) }
  let!(:picture) { create(:picture, :comic, user: user, genre: genre) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end
  context '表示の確認' do
    it 'いいねをする' do
      visit picture_path(picture)
      click_link 'いいね'
      sleep 0.5
      expect(page).to have_css '.glyphicon.glyphicon-heart'
    end
    it 'いいねを外す' do
      visit picture_path(picture)
      click_link 'いいね'
      expect(page).to have_css '.glyphicon.glyphicon-heart-empty'
    end
  end
end

describe 'お気に入り機能のテスト', :js => true do
  let!(:user) { create(:user, :paid) }
  let!(:user2) { create(:user, :paid) }
  let!(:genre) { create(:genre, :active) }
  let!(:picture) { create(:picture, :comic, user: user2, genre: genre) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end
  context 'お気に入りリンクの表示の確認' do
    it 'お気に入りする' do
      visit picture_path(picture)
      click_link 'お気に入り登録'
      expect(page).to have_link 'お気に入りを外す'
    end
    it 'お気に入りを外す' do
      visit picture_path(picture)
      click_link 'お気に入り登録'
      sleep 0.5
      click_link 'お気に入りを外す'
      expect(page).to have_link 'お気に入り登録'
    end
  end
  context 'お気に入り作品の表示の確認' do
    it '表示される' do
      visit picture_path(picture)
      click_link 'お気に入り登録'
      visit bookmarks_path
      expect(page).to have_content picture.title
    end
  end
end