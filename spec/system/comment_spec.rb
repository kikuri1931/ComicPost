require 'rails_helper'

describe 'コメント機能のテスト' do
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_paid2) { create(:user, :paid) }
  let!(:user_free) { create(:user, :free) }
  let!(:genre) { create(:genre, :active) }
  let!(:picture) { create(:picture, :comic, user: user_paid, genre: genre) }

  describe 'コメント投稿のテスト', :js => true do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      it 'コメント投稿に成功する' do
        visit picture_path(picture)
        fill_in 'comment[comment]', with: Faker::Lorem.characters(number:20)
        click_button '送信'
        sleep 4
        expect(page).to have_css '.comment-balloon'
      end
      it 'コメント投稿に失敗する' do
        visit picture_path(picture)
        fill_in 'comment[comment]', with: ''
        click_button '送信'
        sleep 2
        expect(page).to have_content '箇所の入力ミスがあります。'
      end
    end
  end

  describe 'コメント削除(投稿ユーザ)のテスト' do
    context '自分のコメント削除の確認' do
      before do
        create(:comment, user: user_paid, picture: picture)
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid.email
        fill_in 'user[password]', with: user_paid.password
        click_button 'ログインする'
        visit picture_path(picture)
      end
      it 'コメント削除リンクが表示される' do
        expect(page).to have_link('コメント削除')
      end
      it 'コメント削除できる' do
        page.accept_confirm do
          click_link 'コメント削除'
        end
        sleep 1.5
        expect(page).to have_content 'コメント削除が無事に完了しました。'
        expect(current_path).to eq(picture_path(picture))
      end
    end
  end    

  describe 'コメント削除(投稿ユーザ以外)のテスト', :js => true do
    before do
      create(:comment, user: user_paid, picture: picture)
    end
    context '有料会員のコメント削除の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid2.email
        fill_in 'user[password]', with: user_paid2.password
        click_button 'ログインする'
        visit picture_path(picture)
      end
      it 'コメント削除リンクが表示されない' do
        expect(page).to have_no_link('コメント削除')
      end
    end
    context '無料会員のコメント削除の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
        visit picture_path(picture)
      end
      it 'コメント削除リンクが表示されない' do
        expect(page).to have_no_link('コメント削除')
      end
    end
    context '講師のコメント削除の確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user_admin.email
        fill_in 'user[password]', with: user_admin.password
        click_button 'ログインする'
        visit picture_path(picture)
      end
      it 'コメント削除リンクが表示される' do
        expect(page).to have_link('コメント削除')
      end
      it 'コメント削除できる' do
        page.accept_confirm do
          click_link 'コメント削除'
        end
        sleep 0.5
        expect(page).to have_content 'コメント削除が無事に完了しました。'
        expect(current_path).to eq(picture_path(picture))
      end
    end
  end
end
