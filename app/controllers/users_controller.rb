class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find_by_id(params[:id])
     @user.update(user_params)
     redirect_to user_path(@user)

  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :email)
    end
end
