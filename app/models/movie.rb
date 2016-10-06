class Movie < ActiveRecord::Base
  has_many :reviews, as: :reviewable
  has_many :roles
  has_many :actors, through: :roles
  validates :title, uniqueness: true

  def avg_rating
    avg = reviews.average(:rating)
    avg ? avg : 0
  end

  def self.top_movies
    Movie.all.sort_by(&:avg_rating).reverse.first(3)
  end

  def self.all_genres
    @genres ||= Movie.get_all_genres
  end

  private

    def genre_array
      self.genres.split(", ")
    end

    def self.get_all_genres
      genres = []
      Movie.all.each do |movie|
        movie.genre_array.each do |genre|
          genres << genre if !genres.include?(genre)
        end
      end
      genres.sort
    end

end
