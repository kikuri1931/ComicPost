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

  # ログインユーザがすでにいいねしているか確かめるロジック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ログインユーザがすでにお気に入り登録しているか確かめるロジック
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
   
  # ユーザ詳細画面にて投稿された作品を表示するロジック
  def self.user_picture_limit5(status)
    where(status: status).joins(:genre)
                         .where(genres: {is_active: true})
                         .order(id: "DESC")
                         .limit(5)
  end

  # 検索窓でイラストまたはマンガを探すロジック
  def self.search_picture(status, word)
    where(status: status).where("title LIKE?","%#{word}%")
                         .joins(:genre)
                         .where(genres: {is_active: true})
  end

  # ジャンルが有効で、マンガまたはイラストを取得するロジック
  def self.picture_status(status)
    where(status: status).joins(:genre)
                         .where(genres: {is_active: true})
  end

  validates :title, :introduction, :status, presence: true
end
