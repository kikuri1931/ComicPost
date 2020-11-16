require 'rails_helper'

RSpec.describe 'Inquiryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:inquiry) { build(:inquiry) }
    subject { test_inquiry.valid? }

     context 'nameカラム' do
      let(:test_inquiry) { inquiry }
      it '空欄でないこと' do
        test_inquiry.name = ''
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      let(:test_inquiry) { inquiry }
      it '空欄でないこと' do
        test_inquiry.email = ''
        is_expected.to eq false
      end
    end

    context 'messageカラム' do
      let(:test_inquiry) { inquiry }
      it '空欄でないこと' do
        test_inquiry.message = ''
        is_expected.to eq false
      end
    end
  end
end