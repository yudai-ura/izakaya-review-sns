class Category < ApplicationRecord
  has_many :review_category_relations
  has_many :reviews, through: :review_category_relations
end
