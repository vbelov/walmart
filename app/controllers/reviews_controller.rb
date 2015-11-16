class ReviewsController < ApplicationController
  def index
  end

  def search
    @reviews = WalmartClient.find_reviews(params[:product_id], params[:text])
    render :index
  end
end
