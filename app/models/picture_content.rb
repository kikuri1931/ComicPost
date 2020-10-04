class PictureContent < ApplicationRecord
	has_many :pictures, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
end
