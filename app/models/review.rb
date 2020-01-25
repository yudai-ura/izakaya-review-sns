class Review < ApplicationRecord
  belongs_to :user
  
  has_many :review_category_relations, dependent: :destroy
  has_many :categories, through: :review_category_relations
  
  mount_uploader :image, ImageUploader
  
  
  validates :title, presence: { message: "は必ず入力してください"}, length: { message: "25字以内で入力してください", maximum: 25}
  validates :content, presence: { message: "は必ず入力してください"}, length: {message: "1000字以内で入力してください", maximum: 1000}
  validates :point, presence: { message: "は必ず入力してください" }, numericality: { message: "0から100(半角)の整数で入力してください", greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  
  has_many :favorites, foreign_key: 'review_id', dependent: :destroy
  has_many :users, through: :favorites
  
  def self.search(search)
    if search
      Review.where(['title LIKE ?', "%#{search}%"])
    else
      Review.all
    end
  end
  
  
  
end
