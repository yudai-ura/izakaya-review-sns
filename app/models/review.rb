class Review < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 1000}
  validates :title, presence: true, length: {maximum: 25}
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
