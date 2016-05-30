class PetsController < ApplicationController
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

  private
  def pet_params
   params.require(:pet).permit(:name, :gender, :breed, :weight, :bio)
  end
end
