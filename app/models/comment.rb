class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :picture_content
	validates :comment, presence: true
end
