require 'rails_helper'

describe 'ユーザー権限(全てのユーザ共通)のテスト'  do
  let!(:user_admin) { create(:user, :admin) }
  let!(:user_paid) { create(:user, :paid) }
  let!(:genre) { create(:genre) }
  let!(:picture) { create(:picture, :comic, user: user_admin, genre: genre) }
  let!(:room) { create(:room) }
  describe 'ログインしていない場合' do
    context '作品投稿関連のURLにアクセス' do
      it '作品一覧画面に遷移できない' do
        visit pictures_path
        expect(current_path).to eq(new_user_session_path)
      end
      it 'マンガ一覧画面に遷移できない' do
        visit comics_path
        expect(current_path).to eq(new_user_session_path)
      end
      it 'イラスト一覧画面に遷移できない' do
        visit illustrations_path
        expect(current_path).to eq(new_user_session_path)
      end
      it '編集画面に遷移できない' do
        visit edit_picture_path(picture)
        expect(current_path).to eq(new_user_session_path)
      end
      it '詳細画面に遷移できない' do
        visit picture_path(picture)
        expect(current_path).to eq(new_user_session_path)
      end

      it 'お気に入り画面に遷移できない' do
        visit bookmarks_path
        expect(current_path).to eq(new_user_session_path)
      end

      it '新規投稿画面に遷移できない' do
        visit new_picture_path
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context 'ユーザー関連のURLにアクセス' do
      it '一覧画面に遷移できない' do
        visit users_path
        expect(current_path).to eq(new_user_session_path)
      end
      it '編集画面に遷移できない' do
        visit edit_user_path(user_admin)
        expect(current_path).to eq(new_user_session_path)
      end
      it '詳細画面に遷移でない' do
        visit user_path(user_admin)
        expect(current_path).to eq(new_user_session_path)
      end

      it '詳細画面に遷移でない' do
        visit user_path(user_admin)
        expect(current_path).to eq(new_user_session_path)
      end

      it '支払い情報画面に遷移でない' do
        visit user_payments_path(user_paid)
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしていない場合に検索関連のURLにアクセス' do
    context '検索関連のURLにアクセス' do
      it '検索結果画面に遷移できない' do
        visit search_path
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしていない場合にチャット関連のURLにアクセス' do
    before do
      create(:entry, room: room, user: user_admin)
      create(:entry, room: room, user: user_paid)
    end
    context 'チャット関連のURLにアクセス' do
      it 'チャット一覧画面に遷移できない' do
        visit rooms_path
        expect(current_path).to eq(new_user_session_path)
      end

      it 'チャット画面に遷移できない' do
        visit room_path(room)
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしていない場合にジャンル関連のURLにアクセス' do
    context 'ジャンル関連のURLにアクセス' do
      it 'ジャンル一覧画面に遷移できない' do
        visit genres_path
        expect(current_path).to eq(new_user_session_path)
      end

      it 'ジャンル編集画面に遷移できない' do
        visit edit_genre_path(genre)
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end