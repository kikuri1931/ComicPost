class Picture < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :picture_images, dependent: :destroy
  accepts_nested_attributes_for :picture_images
  accepts_attachments_for :picture_images, attachment: :image
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum status: { イラスト: 0, マンガ: 1 }

  scope :genre_active,  -> { joins(:genre).where(genres: {is_active: true}) }
  scope :user_active,  -> { joins(:user).where(users: {is_deleted: false}) }

  # ログインユーザがすでにいいねしているか確かめるロジック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ログインユーザがすでにお気に入り登録しているか確かめるロジック
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
   
  # ユーザ詳細画面にて投稿された作品を表示するロジック
  def self.user_picture_limit4(status)
    where(status: status).joins(:genre)
                         .where(genres: {is_active: true})
                         .order(id: "DESC")
                         .limit(4)
  end

  # ユーザ詳細画面にて作品を表示するロジック
  def self.genre_user_active
    joins(:genre, :user).where(genres: {is_active: true}, users: {is_deleted: false})                    
  end

  # 検索窓でイラストまたはマンガを探すロジック
  def self.search_picture(status, word)
    where(status: status).where("title LIKE?","%#{word}%")
                         .joins(:genre, :user)
                         .where(genres: {is_active: true}, users: {is_deleted: false})
  end

  # 検索窓でジャンル関連の作品を探すロジック
  def self.search_genre_picture(genres)
    where(genre_id: genres).joins(:user).where(users: {is_deleted: false})
  end

  # ジャンルとユーザが有効で、マンガまたはイラストを取得するロジック
  def self.picture_user_genre_active(status)
    where(status: status).joins(:genre, :user)
                         .where(genres: {is_active: true} ,users: {is_deleted: false})
  end

  # ジャンルが有効で、マンガまたはイラストを取得するロジック
  def self.picture_genre_active(status)
    where(status: status).joins(:genre)
                         .where(genres: {is_active: true})
  end

  # ユーザが有効で、マンガまたはイラストを取得するロジック
  def self.picture_user_active(status)
    where(status: status).joins(:user)
                         .where(users: {is_deleted: false})
  end

  validates :title, :introduction, :status, presence: true
end
