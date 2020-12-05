require 'rails_helper'

describe 'お問合せ機能のテスト' do
  describe '入力画面のテスト' do
    before do
      visit inquiries_new_path
    end
    context '表示の確認' do
      it 'お問合せが表示される' do
        expect(page).to have_content 'お問い合わせ'
      end
      it '名前フォームが表示される' do
        expect(page).to have_field 'inquiry[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'inquiry[email]'
      end
      it 'お問い合わせフォームが表示される' do
        expect(page).to have_field 'inquiry[message]'
      end
      it '確認ボタンが表示される' do
        expect(page).to have_button '確認'
      end
    end
    context '確認画面遷移の確認' do
      it '遷移できる' do'inquiry[email]'
        fill_in 'inquiry[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'inquiry[email]', with: Faker::Internet.email
        fill_in 'inquiry[message]', with: Faker::Lorem.characters(number: 20)
        click_button '確認'
        expect(page).to have_button '送信'
      end
      it '遷移できない' do
        fill_in 'inquiry[name]', with: ''
        fill_in 'inquiry[email]', with: '' 
        fill_in 'inquiry[message]', with: ''
        click_button '確認'
        expect(page).to have_no_button '送信'
      end
    end
  end

  describe '確認画面のテスト' do
    before do
      visit inquiries_new_path
      fill_in 'inquiry[name]', with: '山田太郎'
      fill_in 'inquiry[email]', with: 'test@test'
      fill_in 'inquiry[message]', with: 'お問合せ'
      click_button '確認'
    end
    context '表示の確認' do
      it 'お問合せ内容が表示される' do
        expect(page).to have_content '山田太郎'
        expect(page).to have_content 'test@test'
        expect(page).to have_content 'お問合せ'
      end
      it 'thanks画面に遷移する' do
        click_button '送信'
        expect(page).to have_content 'お問い合わせいただきありがとうございました。'
      end
    end
  end
end