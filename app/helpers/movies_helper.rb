module MoviesHelper
  def get_gif(genre)
    response = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{genre}&limit=1&api_key=dc6zaTOxFJmzC")
    response["data"].first["images"]["fixed_height_small"]["url"]
  end

  def genre_movies(genre)
    movies = []
    Movie.all.each do |movie|
      movies << movie if movie.genres.include?(genre)
    end
    movies
  end

  def genre_top_three(genre)
    genre_movies(genre).sort_by(&:avg_rating).reverse.first(3)
  end
end
