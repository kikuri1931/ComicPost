require 'rails_helper'

describe '作品詳細画面のテスト' do
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_nickname) { create(:user, :paid, nickname: Faker::Lorem.characters(number: 5)) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre) }
  let!(:picture) { create(:picture, :comic, user: user_paid, genre: genre) }
  let!(:picture_nickname) { create(:picture, :comic, user: user_nickname, genre: genre) }

  describe '詳細画面(講師ログイン)のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context '表示(ニックネームなし)の確認' do
      before do
        visit picture_path(picture)
      end
      it '詳細画面が表示される' do
        expect(current_path).to eq(picture_path(picture))
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集・画像再選択', href: edit_picture_path(picture)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link 'この作品を削除'
      end
      it 'タイトルが表示される' do
        expect(page).to have_content picture.title
      end
      it '名前が表示される' do
        expect(page).to have_content picture.user.name
      end
      it '説明が表示される' do
        expect(page).to have_content picture.introduction
      end
      it '評価が表示される' do
        expect(page).to have_content 'コメントから判断したみんなの評価'
      end
      it 'コメント入力欄が表示される' do
        expect(page).to have_field 'comment[comment]'
        expect(page).to have_button '送信'
      end
      it 'サイドバーに画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'サイドバーに名前が表示される' do
        expect(page).to have_content '名前'
        expect(page).to have_content picture.user.name
      end
      it 'サイドバーにステータスが表示される' do
        expect(page).to have_content picture.user.status
      end
      it 'サイドバーに新規投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'サイドバーに投稿作品が表示される' do
        expect(page).to have_content '投稿作品'
      end
    end
  end

  describe '詳細画面(投稿ユーザログイン)のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    context '表示(ニックネームなし)の確認' do
      before do
        visit picture_path(picture)
      end
      it '詳細画面が表示される' do
        expect(current_path).to eq(picture_path(picture))
      end
      it '編集リンクが表示される' do
        expect(page).to have_link '編集・画像再選択', href: edit_picture_path(picture)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link 'この作品を削除'
      end
      it 'タイトルが表示される' do
        expect(page).to have_content picture.title
      end
      it '名前が表示される' do
        expect(page).to have_content picture.user.name
      end
      it '説明が表示される' do
        expect(page).to have_content picture.introduction
      end
      it '評価が表示される' do
        expect(page).to have_content 'コメントから判断したみんなの評価'
      end
      it 'コメント入力欄が表示される' do
        expect(page).to have_field 'comment[comment]'
        expect(page).to have_button '送信'
      end
      it 'サイドバーに画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'サイドバーに名前が表示される' do
        expect(page).to have_content '名前'
        expect(page).to have_content picture.user.name
      end
      it 'サイドバーに新規投稿リンクが表示される' do
        expect(page).to have_link '作品を投稿する', href: new_picture_path
      end
      it 'サイドバーにステータスが表示される' do
        expect(page).to have_content picture.user.status
      end
      it 'サイドバーに投稿作品が表示される' do
        expect(page).to have_content '投稿作品'
      end
    end
  end

  describe '詳細画面(投稿ユーザと講師以外ログイン)のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    context '表示(ニックネームなし)の確認' do
      before do
        visit picture_path(picture)
      end
      it '詳細画面が表示される' do
        expect(current_path).to eq(picture_path(picture))
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集・画像再選択', href: edit_picture_path(picture)
      end
      it '削除リンクが表示されない' do
        expect(page).to have_no_link 'この作品を削除'
      end
      it 'タイトルが表示される' do
        expect(page).to have_content picture.title
      end
      it '名前が表示される' do
        expect(page).to have_content picture.user.name
      end
      it '説明が表示される' do
        expect(page).to have_content picture.introduction
      end
      it '評価が表示されない' do
        expect(page).to have_no_content 'コメントから判断したみんなの評価'
      end
      it 'コメント入力欄が表示される' do
        expect(page).to have_field 'comment[comment]'
        expect(page).to have_button '送信'
      end
      it 'サイドバーに画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'サイドバーに名前が表示される' do
        expect(page).to have_content '名前'
        expect(page).to have_content picture.user.name
      end
      it 'サイドバーにステータスが表示される' do
        expect(page).to have_content picture.user.status
      end
      it 'サイドバーに新規投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'サイドバーに投稿作品が表示される' do
        expect(page).to have_content '投稿作品'
      end
    end
  end

  describe 'ニックネーム表示のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
      visit picture_path(picture_nickname)
    end
    context 'ニックネームの確認' do
      it '表示される' do
        expect(page).to have_content picture_nickname.user.nickname
      end
      it 'サイドバーにニックネームが表示される' do
        expect(page).to have_content 'ニックネーム'
        expect(page).to have_content picture_nickname.user.nickname
      end
    end
  end

  describe 'サイドバーの投稿作品のテスト' do
    before do
      create_list(:picture, 3, :comic, user: user_paid, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
      visit picture_path(picture)
    end
    context 'サイドバーの確認' do
      it '「もっと見る」が表示される' do
        expect(page).to have_content 'もっと見る'
      end
    end
    context '「もっと見る」画面遷移の確認' do
      it '作品が表示される' do
        click_link 'もっと見る'
        expect(page).to have_content 'マンガ・イラスト'
      end
    end
  end
end