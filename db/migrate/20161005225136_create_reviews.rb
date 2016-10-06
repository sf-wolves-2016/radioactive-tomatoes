class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review_type
      t.string :title
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.integer :rating
      t.references :reviewer
      t.references :reviewable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
