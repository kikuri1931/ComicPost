require 'rails_helper'

RSpec.describe 'PictureImageモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Pictureモデルとの関係' do
      it 'N:1となっている' do
        expect(PictureImage.reflect_on_association(:picture).macro).to eq :belongs_to
      end
    end
  end
end