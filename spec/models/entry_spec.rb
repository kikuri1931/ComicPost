require 'rails_helper'

RSpec.describe 'Entryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    it "user_idとroom_idが重複する場合は無効" do
      Entry.create(
        user_id: 1,
        room_id: 1
      )

      @entry = Entry.new( 
        user_id: 1,
        room_id: 1
      ) 

     @entry.valid?
      expect(@entry.valid?).to eq(false)
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end