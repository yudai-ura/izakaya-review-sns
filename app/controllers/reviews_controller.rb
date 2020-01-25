class ReviewsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destory]
  before_action :correct_user, only: [:edit, :update, :destory]
  
  PER =
  
  def index
    @reviews = Review.all.page(params[:page]).per(15).order(created_at: :desc).search(params[:search])
    # @reviews = Review.all.page(params[:page]).per(8)
    # @fav_lists = Favorite.group(:review_id).order('count_all desc').count
    # @reviews = Review.find(@fav_lists.keys)
    
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
      flash[:success] = 'レビューを投稿しました。'
      redirect_to reviews_path
    else
      @reviews = current_user.reviews.order(id: :desc)
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
     @review = Review.find(params[:id])

    if @review.update(review_params)
      flash[:success] = 'レビューが更新されました'
      redirect_to @review
    else
      flash.now[:danger] = 'レビューは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:success] = 'レビューが削除されました'
    redirect_to reviews_url
  end
  
  
  def search
      @reviews = Review.search(params[:search])
 
  end

private

  def review_params
    params.require(:review).permit(:title, :content, :point, :image, category_ids: [] )
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
  
end


