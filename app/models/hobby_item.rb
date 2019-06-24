class HobbyItem < ApplicationRecord

  belongs_to :hobby
  has_many :likes, as: :likeable, dependent: :destroy
  mount_uploader :image, PictureUploader

  validates :title, presence: {message: "图片没有输入标题!"}
  validates :content, length: {maximum: 50}
  validates :image, presence: {message: "图片未加入!"}
end
