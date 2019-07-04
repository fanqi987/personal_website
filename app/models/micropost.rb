class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  default_scope {order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}

end
