class ReviewsController < ApplicationController
 before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destory]
  
  def index
    @reviews = Review.order(created_at: :desc)
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to reviews_path
    else
      @reviews = current_user.reviews.order(id: :desc)
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
  end

  def destory
  end
  
private

  def review_params
    params.require(:review).permit(:title, :content, :point)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
  
end
