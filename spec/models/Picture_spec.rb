require 'rails_helper'

RSpec.describe 'Pictureモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:picture) { build(:picture) }
    subject { test_picture.valid? }

     context 'titleカラム' do
      let(:test_picture) { picture }
      it '空欄でないこと' do
        test_picture.title = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      let(:test_picture) { picture }
      it '空欄でないこと' do
        test_picture.introduction = ''
        is_expected.to eq false
      end
    end

    context 'statusカラム' do
      let(:test_picture) { picture }
      it '空欄でないこと' do
        test_picture.status = ''
        is_expected.to eq false
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Picture.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Picture.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end

    context 'PictureImageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Picture.reflect_on_association(:picture_images).macro).to eq :has_many
      end
    end

    context 'Bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(Picture.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Picture.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Picture.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
