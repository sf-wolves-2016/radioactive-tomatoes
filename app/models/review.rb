class Review < ActiveRecord::Base
  has_many :comments
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewable, polymorphic: true

  def actor?
    reviewable_type == 'Actor'
  end

  def reviewable_image_url
    actor? ? reviewable.headshot_url : reviewable.movie_poster_url
  end

  def reviewable_main_text
    actor? ? reviewable.name : reviewable.title
  end

  def top_comments
    comments.order(id: :desc).limit(5)
  end
end
