require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_link 'ComicPost', href: root_path
      end
      it 'お問合せリンクが表示される' do
        expect(page).to have_link 'お問い合わせ', href: inquiries_new_path
      end
      it '新規登録リンクが表示される' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
      it 'ログインリンクが表示される' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
    end
    context 'ヘッダーのリンクを確認' do
      it 'トップ画面に遷移する' do
        click_link 'ComicPost'
        expect(current_path).to eq(root_path)
      end
      it 'お問合せ画面に遷移する' do
        click_link 'お問い合わせ'
        expect(current_path).to eq(inquiries_new_path)
      end
      it '新規登録画面に遷移する' do
        click_link '新規登録'
        expect(current_path).to eq(new_user_registration_path)
      end
      it 'ログイン画面に遷移する' do
        click_link 'ログイン'
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe '講師ログインしている場合' do
    let(:user_admin) { create(:user, :admin) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_link 'ComicPost', href: user_path(user_admin)
      end
      it '検索窓が表示される' do
        expect(page).to have_css('#word')
        expect(page).to have_css('#range')
        expect(page).to have_button('検索')
      end
      it 'ジャンル一覧リンクが表示される' do
        expect(page).to have_link 'ジャンル一覧', href: genres_path
      end
      it '会員一覧リンクが表示される' do
        expect(page).to have_link '会員一覧', href: users_path
      end
      it '作品一覧リンクが表示される' do
        expect(page).to have_link '作品一覧', href: pictures_path
      end
      it 'ログアウトリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
    end

    context 'ヘッダーのリンクを確認' do
      it 'マイページ画面に遷移する' do
        click_link 'ComicPost'
        expect(current_path).to eq(user_path(user_admin))
      end
      it 'ジャンル一覧画面に遷移する' do
        click_link 'ジャンル一覧'
        expect(current_path).to eq(genres_path)
      end
      it '会員一覧画面に遷移する' do
        click_link '会員一覧'
        expect(current_path).to eq(users_path)
      end
      it '作品一覧画面に遷移する' do
        click_link '作品一覧'
        expect(current_path).to eq(pictures_path)
      end
      it 'ログアウトする' do
        click_link 'ログアウト'
        expect(page).to have_content 'ようこそ、ComicPostへ！！'
      end
    end
  end

  describe '有料会員または無料会員がログインしている場合' do
    let(:user_paid) { create(:user, :paid) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_link 'ComicPost', href: user_path(user_paid)
      end
      it '検索窓が表示される' do
        expect(page).to have_css('#word')
        expect(page).to have_css('#range')
        expect(page).to have_button('検索')
      end
      it 'マンガ一覧リンクが表示される' do
        expect(page).to have_link 'マンガ', href: comics_path
      end
      it 'イラスト一覧リンクが表示される' do
        expect(page).to have_link 'イラスト', href: illustrations_path
      end
      it 'お問合せリンクが表示される' do
        expect(page).to have_link 'お問い合わせ', href: inquiries_new_path
      end
      it 'ログアウトリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
    end

    context 'ヘッダーのリンクを確認' do
      it 'マイページ画面に遷移する' do
        click_link 'ComicPost'
        expect(current_path).to eq(user_path(user_paid))
      end
      it 'マンガ一覧画面に遷移する' do
        click_link 'マンガ'
        expect(current_path).to eq(comics_path)
      end
      it 'イラスト一覧画面に遷移する' do
        click_link 'イラスト'
        expect(current_path).to eq(illustrations_path)
      end
      it 'お問合せ画面に遷移する' do
        click_link 'お問い合わせ'
        expect(current_path).to eq(inquiries_new_path)
      end
      it 'ログアウトする' do
        click_link 'ログアウト'
        expect(page).to have_content 'ようこそ、ComicPostへ！！'
      end
    end
  end
end