require 'rails_helper'

describe 'チャット機能のテスト' do
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_paid2) { create(:user, :paid) }
  let!(:user_paid3) { create(:user, :paid) }
  let!(:user_paid4) { create(:user, :paid) }
  let!(:user_free) { create(:user, :free) }

  describe 'ルーム作成のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context 'ルーム未作成時表示の確認' do
      it '「チャット相手はいません。」が表示される' do
        click_link 'チャットする'
        expect(page).to have_content 'チャット相手はいません。'
      end
      it 'ルームに移動する' do
        visit user_path(user_paid)
        click_button 'この人とチャットを始める'
        expect(current_path).to eq('/rooms/1')
      end
    end
  end

  describe 'チャットルーム作成のテスト' do
    let!(:room) { create(:room) }
    before do
      create(:entry, room: room, user: user_admin)
      create(:entry, room: room, user: user_paid2)
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
    end
    context 'ルーム作成の確認' do 
      it 'ルーム一覧に相手の名前が表示される' do
        visit rooms_path
        expect(page).to have_content user_paid2.name
        expect(page).to have_link 'チャットする', href: room_path(room)
      end     
      it '未入力ではメッセージを送信できない' do
        visit room_path(room)
        fill_in 'message[message]', with: ''
        click_button '送信'
        expect(page).to have_no_css '.mymessage'
      end
      it 'メッセージを送信できる' do
        visit room_path(room)
        fill_in 'message[message]', with: 'こんにちは'
        click_button '送信'
        expect(page).to have_content 'こんにちは'
      end
    end

    context '相手のメッセージ表示の確認' do
      before do
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: user_paid2.email
        fill_in 'user[password]', with: user_paid2.password
        click_button 'ログインする'
      end
      it '相手のメッセージが表示される' do
        visit room_path(room)
        expect(page).to have_content 'こんにちは'
      end
    end
  end

  describe '無料会員画面遷移のテスト' do
    let!(:room2) { create(:room) }
    before do
      create(:entry, room: room2, user: user_admin)
      create(:entry, room: room2, user: user_paid3)
      visit new_user_session_path
      fill_in 'user[email]', with: user_free.email
      fill_in 'user[password]', with: user_free.password
      click_button 'ログインする'
    end
    context '画面遷移の確認' do
      it 'チャット一覧画面遷移できない' do
        visit rooms_path
        expect(current_path).to eq(user_path(user_free))
      end

      it 'チャット画面遷移できない' do
        visit room_path(room2)
        expect(current_path).to eq(user_path(user_free))
      end
    end
  end

  describe '他人のチャット画面遷移のテスト' do
    let!(:room3) { create(:room) }
    before do
      create(:entry, room: room3, user: user_admin)
      create(:entry, room: room3, user: user_paid4)
      visit new_user_session_path
      fill_in 'user[email]', with: user_paid.email
      fill_in 'user[password]', with: user_paid.password
      click_button 'ログインする'
    end
    context '画面遷移の確認' do
      it 'チャット画面遷移できない' do
        visit room_path(room3)
        expect(current_path).to eq(user_path(user_paid))
      end
    end
  end
end