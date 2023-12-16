class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :value, presence: true
  validates :review, presence: true
  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_square.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id) #ログインしてない場合エラーが出る
  end

  def self.favorited(user)
    includes(:favorites)
    .where(favorites: { user_id: user.id})
  end
end