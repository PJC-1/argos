class UsersController < ApplicationController


  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
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
    if current_user != nil
      render :show
    else
      flash[:error] = "You are not authorized to preform this function."
      redirect_to users_path
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    if current_user == @user
      render :edit
    else
      flash[:error] = "You are not authorized to preform this function."
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    unless user_params != nil
       Cloudinary::Uploader.upload(user_params)
    end
    if current_user.id == @user.id
      if @user.update(user_params)
        flash[:notice] = "Successfully Updated!"
        redirect_to user_path(@user)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        redirect_to edit_user_path(@user)
      end
    else
      flash[:error] = "You are not authorized to preform this function."
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if current_user == @user
      @user.destroy
      flash[:notice] = "Your profile deleted"
      redirect_to root_path
    else
      flash[:error] = "You are not authorized to preform this function."
      redirect edit_user_path(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :email, :avatar)
    end
end
