require 'rails_helper'

describe '作品詳細画面のテスト' do
  let!(:user) { create(:user, :paid) }
  let!(:deleted_user) { create(:user, :paid, is_deleted: true) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:genre) { create(:genre, :active) } 
  let!(:deleted_genre) { create(:genre, :delete) } 
  let!(:comic) { create(:picture, :comic, user: user, genre: genre) }
  let!(:deleted_user_comic) { create(:picture, :comic, user: deleted_user, genre: genre) }
  let!(:deleted_genre_comic) { create(:picture, :comic, user: user, genre: deleted_genre) }
  let!(:illustration) { create(:picture, :illustration, user: user, genre: genre) }
  let!(:deleted_user_illustration) { create(:picture, :illustration, user: deleted_user, genre: genre) }
  let!(:deleted_genre_illustration) { create(:picture, :illustration, user: user, genre: deleted_genre) }

  describe '作品一覧画面(講師ログイン)のテスト' do
    before do
      create_list(:picture, 13, :comic, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit pictures_path
      end
      it '作品が表示される' do
        expect(page).to have_content comic.title
        expect(page).to have_content illustration.title
      end
      it '退会ユーザ作品が表示される' do
        expect(page).to have_content deleted_user_comic.title
        expect(page).to have_content deleted_user_illustration.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_comic.title
        expect(page).to have_no_content deleted_genre_illustration.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'マンガ'
        expect(page).to have_link 'イラスト'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe '作品一覧画面(有料会員または無料会員ログイン)のテスト' do
    before do
      create_list(:picture, 13, :comic, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit pictures_path
      end
      it '作品が表示される' do
        expect(page).to have_content comic.title
        expect(page).to have_content illustration.title
      end
      it '退会ユーザ作品が表示されない' do
        expect(page).to have_no_content deleted_user_comic.title
        expect(page).to have_no_content deleted_user_illustration.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_comic.title
        expect(page).to have_no_content deleted_genre_illustration.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'マンガ'
        expect(page).to have_link 'イラスト'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe 'マンガ一覧画面(講師ログイン)のテスト' do
    before do
      create_list(:picture, 13, :comic, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit comics_path
      end
      it '作品が表示される' do
        expect(page).to have_content comic.title
      end
      it '退会ユーザ作品が表示される' do
        expect(page).to have_content deleted_user_comic.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_comic.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'イラスト'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe 'マンガ一覧画面(有料会員または無料会員ログイン)のテスト' do
    before do
      create_list(:picture, 13, :comic, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit comics_path
      end
      it '作品が表示される' do
        expect(page).to have_content comic.title
      end
      it '退会ユーザ作品が表示されない' do
        expect(page).to have_no_content deleted_user_comic.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_comic.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'イラスト'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe 'イラスト一覧画面(講師ログイン)のテスト' do
    before do
      create_list(:picture, 13, :illustration, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit illustrations_path
      end
      it '作品が表示される' do
        expect(page).to have_content illustration.title
      end
      it '退会ユーザ作品が表示されない' do
        expect(page).to have_no_content deleted_user_illustration.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_illustration.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'マンガ'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe 'イラスト一覧画面(有料会員または無料会員ログイン)のテスト' do
    before do
      create_list(:picture, 13, :illustration, user: user, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit illustrations_path
      end
      it '作品が表示される' do
        expect(page).to have_content illustration.title
      end
      it '退会ユーザ作品が表示されない' do
        expect(page).to have_no_content deleted_user_illustration.title
      end
      it 'ジャンル無効作品は表示されない' do
        expect(page).to have_no_content deleted_genre_illustration.title
      end
      it 'ジャンル一覧が表示される' do
        expect(page).to have_link 'マンガ'
        expect(page).to have_content genre.genre
        expect(page).to have_no_content deleted_genre.genre
      end
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end
end