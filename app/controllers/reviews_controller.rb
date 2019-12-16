class ReviewsController < ApplicationController
 before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destory]
  
  def index
    
    @reviews = Review.order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
   
    
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
    @review = Review.find(params[:id])
  end

  def update
     @review = Review.find(params[:id])

    if @review.update(review_params)
      flash[:success] = '正常に更新されました'
      redirect_to @review
    else
      flash.now[:danger] = 'は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:success] = '削除されました'
    redirect_to reviews_url
  end
  
private

  def review_params
    params.require(:review).permit(:title, :content, :point, :image)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
  
end
