require 'rails_helper'

describe '検索機能のテスト' do
  let!(:user) { create(:user, :paid) }
  let!(:use2) { create(:user, :paid, nickname: Faker::Lorem.characters(number: 20)) }
  let!(:deleted_user) { create(:user, :paid, is_deleted: true) }
  let!(:genre) { create(:genre) }
  let!(:deleted_genre) { create(:genre, is_active: false) }
  let!(:comic) { create(:picture, :comic, user: user, genre: genre) }
  let!(:deleted_user_comic) { create(:picture, :comic, user: deleted_user, genre: genre) }
  let!(:deleted_comic) { create(:picture, :comic, user: user, genre: deleted_genre) }
  let!(:illustration) { create(:picture, :illustration, user: user, genre: genre) }
  let!(:deleted_user_illustration) { create(:picture, :illustration, user: deleted_user, genre: genre) }
  let!(:deleted_illustration) { create(:picture, :illustration, user: user, genre: deleted_genre) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end
  describe 'ユーザ検索のテスト' do
    context '表示の確認' do
      it '名前が表示される' do
        fill_in 'word', with: user.name
        choose 'ユーザー'
        click_button '検索'
        expect(page).to have_content user.name
        expect(page).to have_content user.status
      end
      it 'ニックネームが表示される' do
        fill_in 'word', with: user2.nickname
        choose 'ユーザー'
        click_button '検索'
        expect(page).to have_content user2.nickname
        expect(page).to have_content user2.status
      end
      it '該当なしが表示される' do
        fill_in 'word', with: 'ああ'
        choose 'ユーザー'
        click_button '検索'
        expect(page).to have_content '該当するユーザはいません'
      end
    end
  end
end