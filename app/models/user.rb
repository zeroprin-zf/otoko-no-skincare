class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board
  validates :name, presence:true

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/figure_dance.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def own?(object)
    id == object.user_id
  end

  def bookmark(item)
    bookmarks_items << item
  end

  def unbookmark(board)
    bookmarks_items.delete(item)
  end

  def bookmark?(item)
    bookmarks_boards.include?(item)
  end

end
