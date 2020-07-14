class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 10 }
  validates :image, presence: true
  #validates :image_name, presence: true
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user

end
