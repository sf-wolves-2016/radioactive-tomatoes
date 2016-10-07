class GenresController < ApplicationController
  def index
  end

  def show
    @genre = Genre.find_by(name: params[:id])
    @movies = @genre.movies
    @top = @movies.sort_by(&:avg_rating).reverse.first(3)
  end
end
