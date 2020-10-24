class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :payments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_picture_contents, through: :bookmarks, source: :picture_content
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  attachment :profile_image

  enum status: { 無料会員: 0, 有料会員: 1, 講師: 2 }

  # 有効会員のみログインできる機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  # 有効会員のみログインできる機能

  # ユーザ検索機能
  def self.search_user(word)
    where(is_deleted: false).where("name LIKE?","%#{word}%")
                            .or(where(is_deleted: false)
                            .where("nickname LIKE?","%#{word}%"))
  end
  # ユーザ検索機能

  # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック
  def login_user_check_entry(other_user)
    result = {
      isRoom: false,
      roomId: nil,
      room: nil,
      entry: nil
    }

    currentUserEntry = entries
    userEntry = other_user.entries
    isRoom = false
    currentUserEntry.each do |cu|
      userEntry.each do |u|
        if cu.room_id == u.room_id
          isRoom = true
          result[:isRoom] = isRoom
          result[:roomId] = cu.room_id
        end
      end
    end
    unless isRoom
      result[:room] = Room.new
      result[:entry] = Entry.new
    end
    result
  end
   # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック

  validates :name, :name_kana, :email, :status, presence: true
  validates :nickname, length: {maximum: 25}
end
