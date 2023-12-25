class Bookmark < ApplicationRecord
  #has_one_attached :image
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :item_id, scope: :user_id
  validates :user_id, uniqueness: { scope: :item_id}

  #def get_image
   # unless image.attached?
    #  file_path = Rails.root.join('app/assets/images/no_image_square.jpg')
     # image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    #image
  #end
end
