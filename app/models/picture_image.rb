class PictureImage < ApplicationRecord
  belongs_to :picture, optional: true
  attachment :image
end
