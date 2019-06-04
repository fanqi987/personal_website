class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

  validates :user_name, presence: true
end
