class Picture < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	belongs_to :picture_content
	attachment :picture
end
