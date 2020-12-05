require 'rails_helper'

describe 'ジャンル画面のテスト' do
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre, :active) }
  describe '一覧画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit genres_path
    end
    context '表示の確認' do
      it 'ジャンル一覧・追加が表示される' do
        expect(page).to have_content 'ジャンル一覧・追加'
      end
      it 'ジャンル追加フォームが表示される' do
        expect(page).to have_field 'genre[genre]'
      end
      it '有効・無効フォームが表示される' do
        expect(page).to have_checked_field('有効')
        expect(page).to have_content '無効'
      end
      it '追加ボタンが表示される' do
        expect(page).to have_button '追加'
      end
      it '一覧にジャンルが表示される' do
        expect(page).to have_content genre.genre
      end
      it '一覧に有効が表示される' do
        expect(page).to have_content '有効'
      end
      it '一覧に編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_genre_path(genre)
      end
    end
    context 'ジャンル追加機能テスト' do
      it '追加できる' do
        fill_in 'genre[genre]', with: 'ジャンル'
        choose '有効'
        click_button '追加'
        expect(page).to have_content 'ジャンル'
      end
      it '追加できない' do
        fill_in 'genre[genre]', with: ''
        choose '有効'
        click_button '追加'
        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit edit_genre_path(genre)
    end
    context '表示の確認' do
      it 'ジャンル編集が表示される' do
        expect(page).to have_content 'ジャンル編集'
      end
      it 'ジャンル編集フォームが表示される' do
        expect(page).to have_field 'genre[genre]', with: genre.genre
      end
      it '有効・無効フォームが表示される' do
        expect(page).to have_checked_field('有効')
        expect(page).to have_content '無効'
      end
      it '追加ボタンが表示される' do
        expect(page).to have_button '変更を保存する'
      end
    end
    context '変更の確認' do
      it 'ジャンル編集ができる' do
        fill_in 'genre[genre]', with: Faker::Lorem.characters(number: 20)
        choose '有効'
        click_button '変更を保存する'
        expect(page).to have_content 'ジャンル変更が無事成功しました。'
      end
      it 'ジャンル編集できない' do
        fill_in 'genre[genre]', with: ''
        choose '有効'
        click_button '変更を保存する'
        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end

  describe 'ページネーションのテスト' do
    before do
      create_list(:genre, 10, :active)
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit genres_path
    end
    context '表示の確認' do
      it 'ページネーションが表示される' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe '画面遷移のテスト' do
    context '有料会員ログイン時の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid.email
        fill_in 'user[password]', with: user_paid.password
        click_button 'ログインする'
        visit genres_path
      end
      it '遷移できない' do
        expect(current_path).to eq(user_path(user_paid))
      end
    end
    context '無料会員ログイン時の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
        visit genres_path
      end
      it '遷移できない' do
        expect(current_path).to eq(user_path(user_free))
      end
    end
  end
end