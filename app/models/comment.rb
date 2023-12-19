class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :comment_content, presence: true
end
