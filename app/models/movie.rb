class Movie < ActiveRecord::Base
  has_many :reviews, as: :reviewable
  has_many :roles
  has_many :actors, through: :roles
  has_and_belongs_to_many :genres
  validates :title, uniqueness: true

  def avg_rating
    avg = reviews.average(:rating)
    avg ? avg : 0
  end

  def self.top_movies
    Movie.all.sort_by(&:avg_rating).reverse.first(3)
  end
end
