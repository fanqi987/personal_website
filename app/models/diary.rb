class Diary < ApplicationRecord
  has_many :likes,as: :likeable,dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  default_scope {order(created_at: :desc)}

  #在列表上显示最多200字
  validates :content, presence: {message: "必须输入文章内容哦!"}
  validates :title, presence: {message: "请输入文章标题!"}, length: {maximum: 20, message: "标题太长了哦~"}
end
