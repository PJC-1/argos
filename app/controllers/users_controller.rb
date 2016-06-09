class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:success] = "Welcome to Argos!"
      login(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find_by_id(params[:id])
     unless user_params != nil
        Cloudinary::Uploader.upload(user_params)
     end
     if current_user.id == @user.id
        @user.update_attributes(user_params)
        flash[:notice] = "Profile updated."
        redirect_to user_path(@user)
     else
        flash[:notice] = @user.errors.full_messages
        redirect_to edit_user_path(@user)
     end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :email, :avatar)
    end
end
