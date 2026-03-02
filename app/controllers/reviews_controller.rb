class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @list = List.find(params["list_id"])
    @review.list = @list
    if @review.save
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

    def destroy
      @review = Review.find(params[:id])
      @list = @review.list
      @review.delete
      redirect_to list_path(@list), status: :see_other
    end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end
