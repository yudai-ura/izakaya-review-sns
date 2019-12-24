class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destory, :followings, :followers, :likes]
  before_action :correct_user, only: [:edit, :update, :destory]
  
  
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(id: :desc)
    counts(@user) 
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "新規ユーザー登録しました"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした'
      render :edit
    end
  end
  
  def destory
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    counts(@user)
  end


  def likes
    @user = User.find(params[:id])
    @favoreview = @user.favoreview
    counts(@user)
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :myimage)
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
  
  
  
end
