class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
    @reviewable = @review.reviewable
    @top_comments = @review.top_comments
    @reviewer = @review.reviewer
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def update
  end
end
