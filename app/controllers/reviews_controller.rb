class ReviewsController < ApplicationController
  before_action :set_property
  def create
    @review = @property.reviews.build(review_params)
    if @review.save
      redirect_to property_path(@property), notice: "Review added"
    else
      redirect_to property_path(@property), alert: "Could not save review"
    end
  end

  def destroy
    @review = @property.reviews.find(params[:id])
    @review.destroy
    redirect_to property_path(@property), notice: "Review deleted"
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
