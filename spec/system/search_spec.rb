require 'rails_helper'

describe '検索機能のテスト' do
  let!(:user) { create(:user, :paid) }
  let!(:user2) { create(:user, :paid, nickname: Faker::Lorem.characters(number: 20)) }
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
        select 'ユーザー'
        click_button '検索'
        expect(page).to have_content user.name
        expect(page).to have_content user.status
      end
      it 'ニックネームが表示される' do
        fill_in 'word', with: user2.nickname
        select 'ユーザー'
        click_button '検索'
        expect(page).to have_content user2.nickname
        expect(page).to have_content user2.status
      end
      it '退会ユーザが表示されない' do
        fill_in 'word', with: deleted_user.name
        select 'ユーザー'
        click_button '検索'
        expect(page).to have_content '該当するユーザはいません'
      end
      it '該当なしが表示される' do
        fill_in 'word', with: 'ああ'
        select 'ユーザー'
        click_button '検索'
        expect(page).to have_content '該当するユーザはいません'
      end
    end
  end

  describe 'マンガ検索のテスト' do
    context '表示の確認' do
      it 'マンガが表示される' do
        fill_in 'word', with: comic.title
        select 'マンガ'
        click_button '検索'
        expect(page).to have_content comic.title
        expect(page).to have_content comic.user.name
      end
      it '退会ユーザ投稿マンガが表示されない' do
        fill_in 'word', with: deleted_user_comic.title
        select 'マンガ'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
      it 'ジャンル無効マンガが表示されない' do
        fill_in 'word', with: deleted_comic.title
        select 'マンガ'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
      it '該当なしが表示される' do
        fill_in 'word', with: 'ああ'
        select 'マンガ'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
    end
  end

  describe 'イラスト検索のテスト' do
    context '表示の確認' do
      it 'イラストが表示される' do
        fill_in 'word', with: illustration.title
        select 'イラスト'
        click_button '検索'
        expect(page).to have_content illustration.title
        expect(page).to have_content illustration.user.name
      end
      it '退会ユーザ投稿イラストが表示されない' do
        fill_in 'word', with: deleted_user_illustration.title
        select 'イラスト'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
      it 'ジャンル無効イラストが表示されない' do
        fill_in 'word', with: deleted_illustration.title
        select 'イラスト'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
      it '該当なしが表示される' do
        fill_in 'word', with: 'ああ'
        select 'イラスト'
        click_button '検索'
        expect(page).to have_content '該当する作品はありせん'
      end
    end
  end

  describe 'ジャンル検索のテスト' do
    context '表示の確認' do
      it '退会ユーザ投稿作品が表示されない' do
        fill_in 'word', with: genre
        select 'ジャンル'
        click_button '検索'
        expect(page).to have_no_content deleted_user_comic.title
        expect(page).to have_no_content deleted_user_comic.user.name
        expect(page).to have_no_content deleted_user_illustration.title
        expect(page).to have_no_content deleted_user_illustration.user.name
      end
      it 'ジャンル無効作品が表示されない' do
        fill_in 'word', with: genre
        select 'ジャンル'
        click_button '検索'
        expect(page).to have_no_content deleted_comic.title
        expect(page).to have_no_content deleted_comic.user.name
        expect(page).to have_no_content deleted_illustration.title
        expect(page).to have_no_content deleted_illustration.user.name
      end
      it '該当なしが表示される' do
        fill_in 'word', with: 'ああ'
        select 'ジャンル'
        click_button '検索'
        expect(page).to have_content '該当するジャンル、または作品はありせん'
      end
    end
  end
end