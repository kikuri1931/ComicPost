require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:message) { build(:message) }
    subject { test_message.valid? }

     context 'messageカラム' do
      let(:test_message) { message }
      it '空欄でないこと' do
        test_message.message = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end