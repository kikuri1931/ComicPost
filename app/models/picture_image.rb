class PictureImage < ApplicationRecord
  belongs_to :picture, optional: true
  attachment :image
  validates :image, presence: true
end
