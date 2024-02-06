class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user, optional: true
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  validates :name, presence: true
  validates :value, presence: true
  validates :review, presence: true
  validates :image, presence: true
  
  scope :latest, -> {order(created_at: :desc)} #最新のものから順に並べる
  scope :old, -> {order(created_at: :asc)} #古いものから順に並べる
  scope :star_count, -> {order(star: :desc)} #星の数が多い順に並べる
  #order データの取り出し
  #created_at 投稿日のカラム
  #desc 昇順
  #asc 降順

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

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end