class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :category

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/no_image_square.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end