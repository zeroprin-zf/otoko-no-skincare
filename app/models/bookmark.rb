class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :item_id, scope: :user_id
  validates :user_id, uniqueness: { scope: :item_id}
end
