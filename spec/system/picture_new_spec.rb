require 'rails_helper'

describe '新規作品関連機能のテスト' do
  let!(:user) { create(:user, :admin) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre, :active) }

  describe '作品投稿のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      it '新規投稿画面が表示される' do
        click_link '作品を投稿する'
        expect(current_path).to eq(new_picture_path)
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
