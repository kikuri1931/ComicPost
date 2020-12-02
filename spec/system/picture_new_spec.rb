require 'rails_helper'

describe '新規作品関連機能のテスト' do
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre, :active) }

  describe '作品投稿(講師ログイン時)のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit new_picture_path
      end
      it '「新規投稿」と表示される' do
        expect(page).to have_content('新規投稿')
      end
      it '画像投稿フォームが表示される' do
        expect(page).to have_field 'picture[picture_images_images][]'
      end
      it 'マンガ・イラスト選択フォームが表示される' do
        expect(page).to have_content 'マンガ'
        expect(page).to have_content 'イラスト'
      end
      it 'タイトルフォームが表示される' do
        expect(page).to have_field 'picture[title]'
      end
      it '説明が表示される' do
        expect(page).to have_field 'picture[introduction]'
      end
      it 'ジャンルが表示される' do
        expect(page).to have_content genre.genre
      end
    end
    context '新規投稿の確認' do
      it '新規投稿に成功する' do
        visit new_picture_path
        choose 'マンガ'
        fill_in 'picture[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'picture[introduction]', with: Faker::Lorem.characters(number: 20)
        find("#picture_genre_id").find("option[value='1']").select_option
        click_button '投稿する'

        expect(page).to have_content 'コメントから判断したみんなの評価'
      end
      it '新規投稿に失敗する' do
        visit new_picture_path
        fill_in 'picture[title]', with: ''
        fill_in 'picture[introduction]', with: ''
        click_button '投稿する'

        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end

  describe '作品投稿(有料会員ログイン時)のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      before do
        visit new_picture_path
      end
      it '「新規投稿」と表示される' do
        expect(page).to have_content('新規投稿')
      end
      it '画像投稿フォームが表示される' do
        expect(page).to have_field 'picture[picture_images_images][]'
      end
      it 'マンガ・イラスト選択フォームが表示される' do
        expect(page).to have_content 'マンガ'
        expect(page).to have_content 'イラスト'
      end
      it 'タイトルフォームが表示される' do
        expect(page).to have_field 'picture[title]'
      end
      it '説明が表示される' do
        expect(page).to have_field 'picture[introduction]'
      end
      it 'ジャンルが表示される' do
        expect(page).to have_content genre.genre
      end
    end
    context '新規投稿の確認' do
      it '新規投稿に成功する' do
        visit new_picture_path
        choose 'マンガ'
        fill_in 'picture[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'picture[introduction]', with: Faker::Lorem.characters(number: 20)
        find("#picture_genre_id").find("option[value='1']").select_option
        click_button '投稿する'

        expect(page).to have_content 'コメントから判断したみんなの評価'
      end
      it '新規投稿に失敗する' do
        visit new_picture_path
        fill_in 'picture[title]', with: ''
        fill_in 'picture[introduction]', with: ''
        click_button '投稿する'

        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end    

  describe '無料会員画面遷移のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    context '画面遷移の確認' do
      it '画面遷移できない' do
        visit new_picture_path
        expect(current_path).to eq(user_path(user_free))
      end
    end
  end  
end
