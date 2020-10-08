class Picture < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	has_many :picture_images, dependent: :destroy
	accepts_nested_attributes_for :picture_images
	accepts_attachments_for :picture_images, attachment: :image
	has_many :bookmarks, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	enum status: {イラスト: 0,マンガ: 1}

  def favorited_by?(user)
	favorites.where(user_id: user.id).exists?
  end

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
