class Genre < ApplicationRecord
  has_many :pictures, dependent: :destroy

  validates :genre, presence: true
  validates :genre, length: {maximum: 15}
  validates :is_active, inclusion: { in: [true, false] }

  # ジャンル検索で、作品を探すロジック
  def self.search_genre(word)
    where(is_active: true).where("genre LIKE?","%#{word}%")
    					  .pluck("id")
  end
end
