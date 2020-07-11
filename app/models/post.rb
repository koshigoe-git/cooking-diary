class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 10 }
  #validates :image_name, presence: true
  #mount_uploader :image, ImageUploader
end
