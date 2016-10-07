class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @top = Movie.top_movies
    @genres = Genre.all.map { |genre| genre.name }.sort()
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
