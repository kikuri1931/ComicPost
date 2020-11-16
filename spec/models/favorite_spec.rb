require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    it "user_idとpicture_idが重複する場合は無効" do
      Favorite.create(
        user_id:    1,
        picture_id: 1
      )

      @favorite = Favorite.new( 
        user_id:    1,
        picture_id: 1
      ) 

     @favorite.valid?
      expect(@favorite.valid?).to eq(false)
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Pictureモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:picture).macro).to eq :belongs_to
      end
    end
  end
end
