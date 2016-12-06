class RatingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @rating = Rating.find(params[:id])
    render json: @rating.as_json
  end

  def index
    @ratings = Rating.for_product(params[:product_id])
    render json: @ratings
  end

  def create
    rating = Rating.new(rating_params)
    if rating.save
      render json: rating.as_json
    else
      render json: {'error' => 'Rating not saved'}
    end
  end

  def update
    rating = Rating.find(params[:id])
    if rating.update(rating_params)
      render json: rating.as_json
    else
      render json: {'error' => 'Rating not saved'}
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.destroy
    render json: {'status' => 'Rating Successfully Deleted'}
  end

  private
    def rating_params
      params.permit(:product_id, :user_id, :title, :body, :stars)
    end
end
