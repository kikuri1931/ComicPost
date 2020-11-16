require 'rails_helper'

RSpec.describe 'Bookmarkモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    it "user_idとpicture_idが重複する場合は無効" do
      Bookmark.create(
        user_id:    1,
        picture_id: 1
      )

      @bookmark = Bookmark.new( 
        user_id:    1,
        picture_id: 1
      ) 

     @bookmark.valid?
      expect(@bookmark.valid?).to eq(false)
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Pictureモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:picture).macro).to eq :belongs_to
      end
    end
  end
end
