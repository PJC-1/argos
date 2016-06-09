class PetsController < ApplicationController
  before_action :authorize, only: [:create, :new, :edit, :update, :destroy]
  def index
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def new
    @pet = Pet.new
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def create
   user = User.find(params[:user_id])
   new_pet = Pet.new(pet_params)
   if new_pet.save
     user.pets << new_pet
     redirect_to user_pet_path(user, new_pet)
   else
     flash[:error] = new_pet.errors.full_messages.join(", ")
     redirect_to new_user_pet_path(user)
   end
  end

  def show
    pet_id = params[:id]
    @pet = Pet.find_by(id: pet_id)
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def edit
    pet_id = params[:id]
    @pet = Pet.find_by(id: pet_id)
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def update
    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    pet_id = params[:id]
    pet = Pet.find_by(id: pet_id)
    unless pet_params != nil
       Cloudinary::Uploader.upload(pet_params)
    end
    if pet.update(pet_params)
      flash[:notice] = "Updated successfully."
      redirect_to user_pet_path(user, pet)
    else
      flash[:error] = pet.errors.full_messages.join(", ")
      redirect_to edit_user_pet_path(user, pet)
    end
  end

  def destroy
    pet_id = params[:id]
    pet = Pet.find_by(id: pet_id)
    pet.delete

    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    redirect_to user_pets_path(user)
  end

  private
  def pet_params
   params.require(:pet).permit(:name, :gender, :breed, :weight, :bio, :pet_avatar)
  end
end
