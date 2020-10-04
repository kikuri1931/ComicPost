class Message < ApplicationRecord
	belongs_to :user
	belongs_to :room

	validates :chat, presence: true
end
