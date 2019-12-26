class CreateReviewCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :review_category_relations do |t|
      t.references :review, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
