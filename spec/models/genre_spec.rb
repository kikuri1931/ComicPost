require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:genre) { build(:genre) }
    subject { test_genre.valid? }

     context 'genreカラム' do
      let(:test_genre) { genre }
      it '空欄でないこと' do
        test_genre.genre = ''
        is_expected.to eq false
      end
    end

    context 'is_activeカラム' do
      let(:test_genre) { genre }
      it '空欄でないこと' do
        test_genre.is_active = ''
        is_expected.to eq false
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Pictureモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:pictures).macro).to eq :has_many
      end
    end
  end
end
