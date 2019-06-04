class Micropost < ApplicationRecord
  belongs_to :user
  has_many :micropost_records, dependent: :destroy
  has_many :likes,as: :likeable,dependent: :destroy

  default_scope {order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}

end
