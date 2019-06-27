class Material < ApplicationRecord
  belongs_to :user

  default_scope {order(created_at: :desc)}
  validates :title, presence: {message: "没有输入素材标题"}
  validates :content, presence: {message: "没有输入素材内容"}
  validates :material_type, presence: {message: "没有选择类别"}
  validates :href, presence: {message: "没有素材链接"}
end
