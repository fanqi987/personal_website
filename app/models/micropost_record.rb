class MicropostRecord < ApplicationRecord
  belongs_to :micropost
  has_many :likes, as: :likeable,dependent: :destroy
  # belongs_to :user
  default_scope {order(created_at: :desc)}

  # validates :user_id, allow_nil: true
  validates :content, length: {maximum: 100}
end
