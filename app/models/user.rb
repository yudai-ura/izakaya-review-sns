class User < ApplicationRecord
  
  mount_uploader :myimage, ImageUploader
  
  before_save { self.email.downcase! }
  validates :name, presence: { message: "を入力してください"}, length: { message: "10字以内で入力してください", maximum: 10 }
  validates :email, presence: { message: "を入力してください"}, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  validates :profile, length: { message: "200字以内で入力してください", maximum: 200 }
  
  has_secure_password
  
  has_many :reviews
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites
  has_many :favoreview, through: :favorites, source: :review
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(review)
    favorites.find_or_create_by(review_id: review.id)
  end

  
  def unlike(review)
    favorite = favorites.find_by(review_id: review.id)
    favorite.destroy if favorite
  end

  
  def favoreview?(review)
    self.favoreview.include?(review)
  end



end
