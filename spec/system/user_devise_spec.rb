require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe '有料会員新規登録' do
    before do
      visit new_user_registration_path
    end
    context '有料会員用新規登録画面に遷移' do
      it '新規登録に成功する' do
        choose '有料会員'
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[name_kana]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[postal_code]', with: '000-0000'
        fill_in 'user[address]', with: Faker::Lorem.characters(number: 20)
        fill_in 'user[telephone_number]', with: '000-0000-0000'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '会員登録する'

        expect(page).to have_content 'ログアウト'
      end
      it '新規登録に失敗する' do
        choose ''
        fill_in 'user[name]', with: ''
        fill_in 'user[name_kana]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[postal_code]', with: ''
        fill_in 'user[address]', with: ''
        fill_in 'user[telephone_number]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '会員登録する'

        expect(page).to have_content '会員登録'
      end
    end
  end

  describe '無料会員新規登録' do
    before do
      visit new_user_registration_path
      find(".free-link").click
    end
    context '無料会員用新規登録画面に遷移' do
      it '新規登録に成功する' do
        choose '無料会員'
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[name_kana]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '会員登録する'

        expect(page).to have_content 'ログアウト'
      end
      it '新規登録に失敗する' do
        choose ''
        fill_in 'user[name]', with: ''
        fill_in 'user[name_kana]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '会員登録する'

        expect(page).to have_content '会員登録'
      end
    end
  end

  describe '有料会員ユーザログイン' do
    let(:user_paid) { create(:user, :paid) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user_paid }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログインする'

        expect(page).to have_content '作品を投稿する'
        expect(page).to have_content 'マンガ'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe '無料会員ユーザログイン' do
    let(:user_free) { create(:user, :free) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user2) { user_free }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user2.email
        fill_in 'user[password]', with: test_user2.password
        click_button 'ログインする'

        expect(page).to have_content 'マンガ'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe '講師ユーザログイン' do
    let(:user_admin) { create(:user, :admin) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user3) { user_admin }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user3.email
        fill_in 'user[password]', with: test_user3.password
        click_button 'ログインする'

        expect(page).to have_content 'ジャンル一覧'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe '退会ユーザログイン' do
    let(:user_paid2) { create(:user, :paid, is_deleted: true) }
    let(:user_free2) { create(:user, :free, is_deleted: true) }
    let(:user_admin2) { create(:user, :admin, is_deleted: true) }

    context '有料会員' do
      before do
        visit new_user_session_path
      end
      it 'ログインに失敗する' do
        fill_in 'user[email]', with: user_paid2.email
        fill_in 'user[password]', with: user_paid2.password
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end

    context '無料会員' do
      before do
        visit new_user_session_path
      end
      it 'ログインに失敗する' do
        fill_in 'user[email]', with: user_free2.email
        fill_in 'user[password]', with: user_free2.password
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end

    context '管理者' do
      before do
        visit new_user_session_path
      end
      it 'ログインに失敗する' do
        fill_in 'user[email]', with: user_admin2.email
        fill_in 'user[password]', with: user_admin2.password
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end