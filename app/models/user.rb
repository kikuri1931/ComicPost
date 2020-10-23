class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :payments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_picture_contents, through: :bookmarks, source: :picture_content
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  attachment :profile_image

  enum status: { 無料会員: 0, 有料会員: 1, 講師: 2 }

  # 有効会員のみログインできる機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  # 有効会員のみログインできる機能

  validates :name, :name_kana, :email, :status, presence: true
end
