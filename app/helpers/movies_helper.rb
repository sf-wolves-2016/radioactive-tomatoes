module MoviesHelper
  def get_gif(genre)
    response = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{genre}&limit=1&api_key=dc6zaTOxFJmzC")
    response["data"].first["images"]["fixed_height_small"]["url"]
  end
end
