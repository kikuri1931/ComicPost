require 'rails_helper'

describe 'トップページのテスト' do
  let!(:user) { create(:user, :paid) }
  before do
    visit root_path
  end
  describe 'ボディ部分のテスト' do
    context '表示の確認' do
      it 'トップページの必要事項が表示される' do
        expect(page).to have_content 'ようこそ、ComicPostへ！！'
        expect(page).to have_content 'ComicPostについて知ろう！'
        expect(page).to have_content 'オンラインでプロからマンガ、イラストを学べる'
        expect(page).to have_content '自分の作品を自由に投稿することができる'
        expect(page).to have_content 'イラストやマンガを無料で見ることができる'
      end
      it '新規会員登録リンクが表示される' do
        expect(page).to have_link '新規会員登録はこちら！', href: new_user_registration_path
      end
    end

    context 'ログインしている場合の挙動を確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログインする'
        visit root_path
      end
      it '新規登録リンクをクリックしたらユーザー詳細画面に遷移する' do
        click_link '新規会員登録はこちら！'
        expect(page).to have_content 'すでにログインしています。'
      end
    end

    context 'ログインしていない場合の挙動を確認' do
      it '新規登録リンクをクリックしたら新規登録画面に遷移する' do
        click_link '新規会員登録はこちら！'
        expect(current_path).to eq(new_user_registration_path)
      end
    end
  end
end