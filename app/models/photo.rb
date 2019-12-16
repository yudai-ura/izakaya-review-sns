class Photo < ApplicationRecord
  belongs_to :review
  mount_uploader :image, ImageUploader
end
