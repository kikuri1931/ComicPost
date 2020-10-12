class Genre < ApplicationRecord
  has_many :pictures, dependent: :destroy

  validates :genre, presence: true
  validates :is_active, inclusion: { in: [true, false] }
end
