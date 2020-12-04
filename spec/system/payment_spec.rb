require 'rails_helper'

describe '支払い機能のテスト' do
  let!(:user_paid) { create(:user, :paid) }
  let!(:user_admin) { create(:user, :admin) }
  describe '支払い情報画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit user_payments_path(user_paid)
    end
    context '表示の確認' do
      it '相手の名前が表示される' do
        expect(page).to have_content user_paid.name
      end
      it '今月のお支払いが表示される' do
        expect(page).to have_content Payment.this_month_payment.to_s(:delimited, delimiter: ',')
        expect(page).to have_content Payment.taxin_payment.floor.to_s(:delimited, delimiter: ',')
      end
      it '支払い情報入力フォームが表示される' do
        expect(page).to have_content '未払い'
        expect(page).to have_button '更新'
      end
      it '今までの支払いが表示される' do
        expect(page).to have_content user_paid.payments.sum(:payment).to_s(:delimited, delimiter: ',')
        expect(page).to have_content user_paid.payments.sum(:taxin_payment).to_s(:delimited, delimiter: ',')
      end
    end
  end

  describe '支払い情報更新のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit user_payments_path(user_paid)
    end
    context '更新の確認' do
      it '更新できる' do
        find("#payment_status").find("option[value='支払い済み']").select_option
        page.accept_confirm do
          click_button '更新'
        end
        expect(page).to have_content 'お支払い情報を無事更新しました。'
      end
    end
  end

  describe '支払い情報更新後の表示のテスト' do
    let!(:payment) { create(:payment, user: user_paid) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user_admin.email
      fill_in 'user[password]', with: user_admin.password
      click_button 'ログインする'
      visit user_payments_path(user_paid)
    end
    context '表示の確認' do
      it '更新結果が表示される' do
        expect(page).to have_content payment.created_at.strftime("%Y-%m-%d")
        expect(page).to have_content payment.payment.to_s(:delimited, delimiter: ',')
        expect(page).to have_content (payment.payment * Payment.tax).floor.to_s(:delimited, delimiter: ',')
        expect(page).to have_content payment.status
      end
    end
  end
end