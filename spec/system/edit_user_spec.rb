require 'rails_helper'

describe 'ユーザ編集ページのテスト' do
	let(:user_paid) { create(:user, :paid) }
	let!(:user_paid2) { create(:user, :paid) }
  let!(:user_free) { create(:user, :free) }
  let!(:user_free2) { create(:user, :free) }
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_admin2) { create(:user, :admin) }
  context '自分(有料会員)の編集画面への遷移' do
  	before do
  		visit new_user_session_path 
  		fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    it '遷移できる' do
      visit edit_user_path(user_paid)
      expect(current_path).to eq(edit_user_path(user_paid))
    end
  end
  context '他人の編集画面への遷移' do
  	before do
  		visit new_user_session_path 
  		fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    it '遷移できない(有料会員)' do
      visit edit_user_path(user_paid2)
      expect(current_path).to eq(user_path(user_paid))
    end
    it '遷移できない(無料会員)' do
      visit edit_user_path(user_free)
      expect(current_path).to eq(user_path(user_paid))
    end
    it '遷移できない(講師)' do
      visit edit_user_path(user_admin)
      expect(current_path).to eq(user_path(user_paid))
    end
  end

  context '自分(無料会員)の編集画面への遷移' do
  	before do 
  		visit new_user_session_path
  		fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    it '遷移できる' do
      visit edit_user_path(user_free)
      expect(current_path).to eq(edit_user_path(user_free))
    end
  end
  context '他人の編集画面への遷移' do
  	 	before do 
  		visit new_user_session_path
  		fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    it '遷移できない(有料会員)' do
      visit edit_user_path(user_paid)
      expect(current_path).to eq(user_path(user_free))
    end
    it '遷移できない(無料会員)' do
      visit edit_user_path(user_free2)
      expect(current_path).to eq(user_path(user_free))
    end
    it '遷移できない(講師)' do
      visit edit_user_path(user_admin)
      expect(current_path).to eq(user_path(user_free))
    end
  end

  context '自分(講師)の編集画面への遷移' do
  	before do 
  		visit new_user_session_path
  		fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    it '遷移できる' do
      visit edit_user_path(user_admin)
      expect(current_path).to eq(edit_user_path(user_admin))
    end
  end
  context '他人の編集画面への遷移' do
  	before do 
  		visit new_user_session_path
  		fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    it '遷移できる(有料会員)' do
      visit edit_user_path(user_paid)
      expect(current_path).to eq(edit_user_path(user_paid))
    end
    it '遷移できる(無料会員)' do
      visit edit_user_path(user_free)
      expect(current_path).to eq(edit_user_path(user_free))
    end
    it '遷移できない(講師)' do
      visit edit_user_path(user_admin2)
      expect(current_path).to eq(user_path(user_admin))
    end
  end

  context '有料会員表示の確認' do
    before do
    	visit new_user_session_path
    	fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
      visit edit_user_path(user_paid)
    end
    it '「登録情報編集」と表示される' do
      expect(page).to have_content('登録情報編集')
    end
    it '画像編集フォームが表示される' do
      expect(page).to have_field 'user[profile_image]'
    end
    it 'ニックネーム編集フォームが表示される' do
      expect(page).to have_field 'user[nickname]'
    end
    it '氏名編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user_paid.name
    end
    it '氏名(かな)編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name_kana]', with: user_paid.name_kana
    end
    it '郵便番号編集フォームに自分の郵便番号が表示される' do
      expect(page).to have_field 'user[postal_code]', with: user_paid.postal_code
    end
    it '住所編集フォームに自分の住所が表示される' do
      expect(page).to have_field 'user[address]', with: user_paid.address
    end
    it '電話番号編集フォームに自分の電話番号が表示される' do
      expect(page).to have_field 'user[telephone_number]', with: user_paid.telephone_number
    end
    it 'メールアドレスフォームに自分のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user_paid.email
    end
    it '編集に成功する' do
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '更新が無事に完了しました。'
      expect(current_path).to eq(user_path(user_paid))
    end
    it '編集に失敗する' do
      fill_in 'user[name]', with: ''
      fill_in 'user[name_kana]', with: ''
      fill_in 'user[email]', with: ''
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '登録情報編集'
      expect(current_path).to eq(edit_user_path(user_paid))
    end
  end

  context '無料会員表示の確認' do
    before do
    	visit new_user_session_path
    	fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
      visit edit_user_path(user_free)
    end
    it '「登録情報編集」と表示される' do
      expect(page).to have_content('登録情報編集')
    end
    it '画像編集フォームが表示される' do
      expect(page).to have_field 'user[profile_image]'
    end
    it 'ニックネーム編集フォームが表示される' do
      expect(page).to have_field 'user[nickname]'
    end
    it '氏名編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user_free.name
    end
    it '氏名(かな)編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name_kana]', with: user_free.name_kana
    end
    it '郵便番号編集フォームが表示される' do
      expect(page).to have_field 'user[postal_code]'
    end
    it '住所編集フォームが表示される' do
      expect(page).to have_field 'user[address]'
    end
    it '電話番号編集フォームが表示される' do
      expect(page).to have_field 'user[telephone_number]'
    end
    it 'メールアドレスフォームに自分のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user_free.email
    end
    it '編集に成功する' do
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '更新が無事に完了しました。'
      expect(current_path).to eq(user_path(user_free))
    end
    it '編集に失敗する' do
      fill_in 'user[name]', with: ''
      fill_in 'user[name_kana]', with: ''
      fill_in 'user[email]', with: ''
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '登録情報編集'
      expect(current_path).to eq(edit_user_path(user_free))
    end
  end

  context '講師表示の確認' do
    before do
    	visit new_user_session_path
    	fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit edit_user_path(user_admin)
    end
    it '「登録情報編集」と表示される' do
      expect(page).to have_content('登録情報編集')
    end
    it '画像編集フォームが表示される' do
      expect(page).to have_field 'user[profile_image]'
    end
    it 'ニックネーム編集フォームが表示される' do
      expect(page).to have_field 'user[nickname]'
    end
    it '氏名編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user_admin.name
    end
    it '氏名(かな)編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name_kana]', with: user_admin.name_kana
    end
    it '郵便番号編集フォームが表示される' do
      expect(page).to have_field 'user[postal_code]'
    end
    it '住所編集フォームが表示される' do
      expect(page).to have_field 'user[address]'
    end
    it '電話番号編集フォームが表示される' do
      expect(page).to have_field 'user[telephone_number]'
    end
    it 'メールアドレスフォームに自分のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user_admin.email
    end
    it '編集に成功する' do
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '更新が無事に完了しました。'
      expect(current_path).to eq(user_path(user_admin))
    end
    it '編集に失敗する' do
      fill_in 'user[name]', with: ''
      fill_in 'user[name_kana]', with: ''
      fill_in 'user[email]', with: ''
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '登録情報編集'
      expect(current_path).to eq(edit_user_path(user_admin))
    end
  end

  context '講師ログイン時、有料会員表示の確認' do
    before do
    	visit new_user_session_path
    	fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit edit_user_path(user_paid)
    end
    it '「xxさんの登録情報編集」と表示される' do
      expect(page).to have_content('さんの登録情報編集')
    end
    it '会員ステータス選択ボタンが表示される' do
      expect(page).to have_content '無料会員'
      expect(page).to have_checked_field('有料会員')
    end
    it '有効/退会ボタンが表示される' do
      expect(page).to have_checked_field('有効')
      expect(page).to have_content '退会'
    end
    it '講師登録ボタンが表示される' do
      expect(page).to have_content 'はい'
    end
    it '氏名編集フォームに相手の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user_paid.name
    end
    it '氏名(かな)編集フォームに相手の名前が表示される' do
      expect(page).to have_field 'user[name_kana]', with: user_paid.name_kana
    end
    it '郵便番号編集フォームに相手の郵便番号が表示される' do
      expect(page).to have_field 'user[postal_code]', with: user_paid.postal_code
    end
    it '住所編集フォームに相手の住所が表示される' do
      expect(page).to have_field 'user[address]', with: user_paid.address
    end
    it '電話番号編集フォームに相手の電話番号が表示される' do
      expect(page).to have_field 'user[telephone_number]', with: user_paid.telephone_number
    end
    it 'メールアドレスフォームに相手のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user_paid.email
    end
    it '編集に成功する' do
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '更新が無事に完了しました。'
      expect(current_path).to eq(user_path(user_paid))
    end
    it '編集に失敗する' do
      fill_in 'user[name]', with: ''
      fill_in 'user[name_kana]', with: ''
      fill_in 'user[email]', with: ''
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '登録情報編集'
      expect(current_path).to eq(edit_user_path(user_paid))
    end
  end

  context '講師ログイン時、無料会員表示の確認' do
    before do
    	visit new_user_session_path
    	fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit edit_user_path(user_free)
    end
    it '「xxさんの登録情報編集」と表示される' do
      expect(page).to have_content('さんの登録情報編集')
    end
    it '会員ステータス選択ボタンが表示される' do
      expect(page).to have_content '有料会員'
      expect(page).to have_checked_field('無料会員')
    end
    it '有効/退会ボタンが表示される' do
      expect(page).to have_checked_field('有効')
      expect(page).to have_content '退会'
    end
    it '講師登録ボタンが表示される' do
      expect(page).to have_content 'はい'
    end
        it '氏名編集フォームに相手の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user_free.name
    end
    it '氏名(かな)編集フォームに相手の名前が表示される' do
      expect(page).to have_field 'user[name_kana]', with: user_free.name_kana
    end
    it '郵便番号編集フォームが表示される' do
      expect(page).to have_field 'user[postal_code]'
    end
    it '住所編集フォームが表示される' do
      expect(page).to have_field 'user[address]'
    end
    it '電話番号編集フォームが表示される' do
      expect(page).to have_field 'user[telephone_number]'
    end
    it 'メールアドレスフォームに相手のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user_free.email
    end
    it '編集に成功する' do
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '更新が無事に完了しました。'
      expect(current_path).to eq(user_path(user_free))
    end
    it '編集に失敗する' do
      fill_in 'user[name]', with: ''
      fill_in 'user[name_kana]', with: ''
      fill_in 'user[email]', with: ''
      page.accept_confirm do
        click_button '登録する'
      end
      expect(page).to have_content '登録情報編集'
      expect(current_path).to eq(edit_user_path(user_free))
    end
  end

  context '退会の確認' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
      visit edit_user_path(user_free)
    end
    it '退会できる' do
      page.accept_confirm do
        click_link '退会'
      end
      expect(current_path).to eq(root_path)
    end
  end
end