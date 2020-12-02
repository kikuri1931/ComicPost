require 'rails_helper'

describe '作品編集画面のテスト' do
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre, :active) } 
  let!(:picture) { create(:picture, :comic, user: user_paid, genre: genre) }

  describe '編集画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit edit_picture_path(picture)
      end
      it '「作品編集」と表示される' do
      expect(page).to have_content('作品編集')
      end
      it '画像投稿フォームが表示される' do
        expect(page).to have_field 'picture[picture_images_images][]'
      end
      it 'マンガ・イラスト選択フォームが表示される' do
        expect(page).to have_checked_field('マンガ')
        expect(page).to have_content 'イラスト'
      end
      it 'タイトルフォームにタイトルが表示される' do
        expect(page).to have_field 'picture[title]', with: picture.title
      end
      it '説明に説明が表示される' do
        expect(page).to have_field 'picture[introduction]', with: picture.introduction
      end
      it 'ジャンルが表示される' do
        expect(page).to have_content picture.genre.genre
      end
      it '編集に成功する' do
        click_button '投稿する'
        expect(page).to have_content '作品を無事に更新できました。'
        expect(current_path).to eq(picture_path(picture))
      end
      it '編集に失敗する' do
        fill_in 'picture[title]', with: ''
        fill_in 'picture[introduction]', with: ''
        click_button '投稿する'
        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end

  describe '編集画面遷移のテスト' do
    context '講師ログイン時の画面遷移確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_admin.email
        fill_in 'user[password]', with: user_admin.password
        click_button 'ログインする'
      end
      it '画面遷移に失敗する' do
        visit edit_picture_path(picture)
        expect(current_path).to eq(user_path(user_admin))
      end
    end

    context '無料会員ログイン時の画面遷移確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
      end
      it '画面遷移に失敗する' do
        visit edit_picture_path(picture)
        expect(current_path).to eq(user_path(user_free))
      end
    end
  end
end

describe '作品削除のテスト' do
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:genre) { create(:genre, :active) } 
  let!(:picture) { create(:picture, :comic, user: user_paid, genre: genre) }
  let!(:picture2) { create(:picture, :comic, user: user_paid, genre: genre) }

  describe '削除のテスト' do
    context '有料会員ログイン時の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid.email
        fill_in 'user[password]', with: user_paid.password
        click_button 'ログインする'
      end
      it '削除ができる' do
        visit picture_path(picture)
        page.accept_confirm do
          click_link 'この作品を削除'
        end
        expect(page).to have_content '削除が無事に完了しました。'
        expect(current_path).to eq(user_path(user_paid))
      end
    end
    context '講師ログイン時の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_admin.email
        fill_in 'user[password]', with: user_admin.password
        click_button 'ログインする'
      end
      it '削除ができる' do
        visit picture_path(picture2)
        page.accept_confirm do
          click_link 'この作品を削除'
        end
        expect(page).to have_content '削除が無事に完了しました。'
        expect(current_path).to eq(user_path(user_admin))
      end
    end
  end
end