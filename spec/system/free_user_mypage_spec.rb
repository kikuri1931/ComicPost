require 'rails_helper'

describe '無料会員(マイページ)のテスト' do
  describe '無料会員マイページ(投稿作品以外)のテスト' do
    let(:user_free) { create(:user, :free) }
    let!(:user_free2) { create(:user, :free) }
    let!(:user_paid) { create(:user, :paid) }
    let!(:user_admin) { create(:user, :admin) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    context '表示の確認' do
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'ステータスが表示される' do
        expect(page).to have_content(user_free.status)
      end
      it '編集リンクが表示される' do
        expect(page).to have_link '登録情報を編集する', href: edit_user_path(user_free)
      end
      it 'お気に入りリンクが表示される' do
        expect(page).to have_link 'お気に入り', href: bookmarks_path
      end
      it 'チャットリンクが表示されない' do
        expect(page).to have_no_link 'チャットする', href: rooms_path
      end
      it '作品投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'チャット開始ボタンが表示されない' do
        expect(page).to have_no_button 'この人とチャットを始める'
      end
      it '個人情報が表示されない' do
        expect(page).to have_no_css('table-bordered')
      end
    end

    context '氏名表示の確認' do 
      it 'ニックネームが登録されていないとき氏名が表示される' do
        expect(page).to have_content(user_free.name)
      end
    end

    context 'ニックネーム表示の確認' do 
      before do
        visit edit_user_path(user_free)
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 20)
        page.accept_confirm do
          click_button '登録する'
        end
      end
      it 'ニックネームが登録されているときニックネームが表示される' do
        visit user_path(user_free)
        expect(page).to have_content(user_free.nickname)
      end
    end

    context 'オススメ作品表示の確認' do 
      it 'オススメ作品が表示される' do
        expect(page).to have_content('おすすめ作品')
      end
    end

    context '他人(有料会員)のマイページの確認' do
      before do 
        visit user_path(user_paid)
      end
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'ステータスが表示される' do
        expect(page).to have_content(user_paid.status)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '登録情報を編集する', href: edit_user_path(user_paid)
      end
      it 'お気に入りリンクが表示されない' do
        expect(page).to have_no_link 'お気に入り', href: bookmarks_path
      end
      it 'チャットリンクが表示されない' do
        expect(page).to have_no_link 'チャットする', href: rooms_path
      end
      it '作品投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'オススメ作品が表示されない' do
        expect(page).to have_no_content('おすすめ作品')
      end
      it 'チャット開始ボタンが表示されない' do
        expect(page).to have_no_button 'この人とチャットを始める'
      end
      it '個人情報が表示されない' do
        expect(page).to have_no_css('table-bordered')
      end
      it 'ニックネームが登録されていないとき氏名が表示される' do
        expect(page).to have_content(user_paid.name)
      end
    end

    context '他人(有料会員)のニックネーム表示確認' do
      before do 
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid.email
        fill_in 'user[password]', with: user_paid.password
        click_button 'ログインする'
        visit edit_user_path(user_paid)
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 20)
        page.accept_confirm do
          click_button '登録する'
        end
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
        visit user_path(user_paid)
      end
      it 'ニックネームが表示される' do
        expect(page).to have_content(user_paid.nickname)
      end
    end

    context '他人(無料会員)のマイページの確認' do
      before do 
        visit user_path(user_free2)
      end
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'ステータスが表示される' do
        expect(page).to have_content(user_free2.status)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '登録情報を編集する', href: edit_user_path(user_free2)
      end
      it 'お気に入りリンクが表示されない' do
        expect(page).to have_no_link 'お気に入り', href: bookmarks_path
      end
      it 'チャットリンクが表示されない' do
        expect(page).to have_no_link 'チャットする', href: rooms_path
      end
      it '作品投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'オススメ作品が表示されない' do
        expect(page).to have_no_content('おすすめ作品')
      end
      it 'チャット開始ボタンが表示されない' do
        expect(page).to have_no_button 'この人とチャットを始める'
      end
      it '個人情報が表示されない' do
        expect(page).to have_no_css('table-bordered')
      end
      it 'ニックネームが登録されていないとき氏名が表示される' do
        expect(page).to have_content(user_free2.name)
      end
    end

    context '他人(無料会員)のニックネーム表示確認' do
      before do 
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_free2.email
        fill_in 'user[password]', with: user_free2.password
        click_button 'ログインする'
        visit edit_user_path(user_free2)
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 20)
        page.accept_confirm do
          click_button '登録する'
        end
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
        visit user_path(user_free2)
      end
      it 'ニックネームが表示される' do
        expect(page).to have_content(user_free2.nickname)
      end
    end

    context '他人(講師)のマイページの確認' do
      before do 
        visit user_path(user_admin)
      end
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it 'ステータスが表示される' do
        expect(page).to have_content(user_admin.status)
      end
      it 'ニックネームが登録されていないとき氏名が表示される' do
        expect(page).to have_content(user_admin.name)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '登録情報を編集する', href: edit_user_path(user_admin)
      end
      it 'お気に入りリンクが表示されない' do
        expect(page).to have_no_link 'お気に入り', href: bookmarks_path
      end
      it 'チャットリンクが表示されない' do
        expect(page).to have_no_link 'チャットする', href: rooms_path
      end
      it '作品投稿リンクが表示されない' do
        expect(page).to have_no_link '作品を投稿する', href: new_picture_path
      end
      it 'オススメ作品が表示されない' do
        expect(page).to have_no_content('おすすめ作品')
      end
      it 'チャット開始ボタンが表示されない' do
        expect(page).to have_no_button 'この人とチャットを始める'
      end
      it '個人情報が表示されない' do
        expect(page).to have_no_css('table-bordered')
      end
    end

    context '他人(講師)のニックネーム表示確認' do
      before do 
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_admin.email
        fill_in 'user[password]', with: user_admin.password
        click_button 'ログインする'
        visit edit_user_path(user_admin)
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 20)
        page.accept_confirm do
          click_button '登録する'
        end
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_free.email
        fill_in 'user[password]', with: user_free.password
        click_button 'ログインする'
        visit user_path(user_admin)
      end
      it 'ニックネームが表示される' do
        expect(page).to have_content(user_admin.nickname)
      end
    end
  end

  describe '有料会員マイページ(投稿作品)のテスト' do
    let(:user_free2) { create(:user, :free) }
    let!(:user_paid2) { create(:user, :paid) }
    let!(:user_admin2) { create(:user, :admin) }
    let!(:genre) { create(:genre) }

    before do
      create(:picture, :comic, user: user_paid2, genre: genre)
      create(:picture, :comic, user: user_admin2, genre: genre)
      create(:picture, :illustration, user: user_paid2, genre: genre)
      create(:picture, :illustration, user: user_admin2, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_free2.email
      fill_in 'user[password]', with: user_free2.password
      click_button 'ログインする'
    end

    context '他人(有料会員)の表示確認' do
      before do 
        visit user_path(user_paid2)
      end
      it 'マンガが表示される' do
        expect(page).to have_content('マンガ作品')
      end
      it 'イラストが表示される' do
        expect(page).to have_content('イラスト作品')
      end
    end

    context '他人(講師)の表示確認' do
      before do 
        visit user_path(user_admin2)
      end
      it 'マンガが表示される' do
        expect(page).to have_content('マンガ作品')
      end
      it 'イラストが表示される' do
        expect(page).to have_content('イラスト作品')
      end
    end
  end

  describe '有料会員マイページ(マンガ「もっと見る」表示確認)のテスト' do
    let(:user_free3) { create(:user, :free) }
    let!(:user_paid3) { create(:user, :paid) }
    let!(:user_admin3) { create(:user, :admin) }
    let!(:genre) { create(:genre) }

    before do
      create_list(:picture, 4, :comic, user: user_paid3, genre: genre)
      create_list(:picture, 4, :comic, user: user_admin3, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_free3.email
      fill_in 'user[password]', with: user_free3.password
      click_button 'ログインする'
    end

    context '他人(有料会員)の表示確認' do
      before do 
        visit user_path(user_paid3)
      end
      it '「もっと見る」が表示される' do
        expect(page).to have_content('もっと見る')
      end
    end

    context '他人(講師)の表示確認' do
      before do 
        visit user_path(user_admin3)
      end
      it '「もっと見る」が表示される' do
        expect(page).to have_content('もっと見る')
      end
    end
  end

  describe '有料会員マイページ(イラスト「もっと見る」表示確認)のテスト' do
    let(:user_free4) { create(:user, :free) }
    let!(:user_paid4) { create(:user, :paid) }
    let!(:user_admin4) { create(:user, :admin) }
    let!(:genre) { create(:genre) }

    before do
      create_list(:picture, 4, :illustration, user: user_paid4, genre: genre)
      create_list(:picture, 4, :illustration, user: user_admin4, genre: genre)
      visit new_user_session_path
      fill_in 'user[email]', with: user_free4.email
      fill_in 'user[password]', with: user_free4.password
      click_button 'ログインする'
    end

    context '他人(有料会員)の表示確認' do
      before do 
        visit user_path(user_paid4)
      end
      it '「もっと見る」が表示される' do
        expect(page).to have_content('もっと見る')
      end
    end

    context '他人(講師)の表示確認' do
      before do 
        visit user_path(user_admin4)
      end
      it '「もっと見る」が表示される' do
        expect(page).to have_content('もっと見る')
      end
    end
  end    
end