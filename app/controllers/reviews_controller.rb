class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
    @reviewable = @review.reviewable
    @top_comments = @review.top_comments
    @reviewer = @review.reviewer
  end

  def create
    if current_user
      @review = Review.create(review_params)
      if @review.save
        redirect_to "/#{@review.reviewable_type.downcase}s/#{@review.reviewable_id}"
      end
    else
      flash[:error] = "Sorry, you must be signed in to your account to post a review."
      redirect_to '/signup'
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private

    def review_params
      param_results = params.require(:review).permit(
        :title, :content, :rating, :reviewer_id, :reviewable_id, :reviewable_type)
      param_results[:reviewer_id] = current_user.id
      param_results
    end
end
