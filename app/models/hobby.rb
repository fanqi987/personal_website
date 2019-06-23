class Hobby < ApplicationRecord
  belongs_to :user
  has_many :hobby_items, dependent: :destroy

  default_scope {order(created_at: :desc)}

  validates :title, presence: {message: "画廊栏目没有输入标题!"},
            length: {maximum: 20, message: "标题太长了!"}
  validates :content, length: {maximum: 50, message: "描述太长了!"}
end