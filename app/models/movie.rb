class Movie < ActiveRecord::Base
  has_many :reviews, as: :reviewable
  has_many :roles
  has_many :actors, through: :roles
  validates :title, uniqueness: true

  def avg_rating
    reviews.average(:rating)
  end
end
