class Bookmark < ApplicationRecord
	belongs_to :user
	belongs_to :picture_content
	validates :user_id, :uniqueness => {:scope => :picture_content_id}
end
