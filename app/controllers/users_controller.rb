class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
    @new_book = Book.new 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id 
      redirect_to user_path(current_user)
    end
  end
end
