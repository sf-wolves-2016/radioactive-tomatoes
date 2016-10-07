class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @top = Movie.top_movies
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
