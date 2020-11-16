require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }

     context 'statusカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.status = ''
        is_expected.to eq false
      end
    end

    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
    end

    context 'name_kanaカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name_kana = ''
        is_expected.to eq false
      end
    end

    context 'nicknameカラム' do
      let(:test_user) { user }
      it '25文字以下であること' do
        test_user.nickname = Faker::Lorem.characters(number:26)
        is_expected.to eq false
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Paymentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:payments).macro).to eq :has_many
      end
    end

    context 'Pictureモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:pictures).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
  end
end
