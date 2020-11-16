require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:comment) { build(:comment) }
    subject { test_comment.valid? }

     context 'commentカラム' do
      let(:test_comment) { comment }
      it '空欄でないこと' do
        test_comment.comment = ''
        is_expected.to eq false
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Pictureモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:picture).macro).to eq :belongs_to
      end
    end
  end
end