class Item < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy
  belongs_to :category
end
