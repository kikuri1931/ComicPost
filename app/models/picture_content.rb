class PictureContent < ApplicationRecord
	has_many :pictures, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
