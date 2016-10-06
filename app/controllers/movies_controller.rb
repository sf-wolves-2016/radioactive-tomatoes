class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @top = Movie.top_movies
    @genres = Movie.all_genres
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
