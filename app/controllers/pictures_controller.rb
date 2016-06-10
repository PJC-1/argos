class PicturesController < ApplicationController
  before_action :authorize, only: [:create, :new, :edit, :update, :destroy]

  def index
    @pictures = Picture.all.paginate(:page => params[:page], :per_page => 10)
    pet_id = params[:pet_id]
    @pet = Pet.find_by(id: pet_id)
  end

  def new
    @picture = Picture.new
    pet_id = params[:pet_id]
    @pet = Pet.find_by(id: pet_id)
  end

  def show
    @picture = Picture.find_by_id(params[:id])
    @pet = Pet.find_by_id(params[:pet_id])
  end

  def create
    @picture = Picture.create(picture_params)
    Cloudinary::Uploader.upload(params[:picture][:photo])
    @pet = current_user.pets.find_by_id(params[:pet_id])
    @pet.pictures << @picture
    redirect_to pet_pictures_path
  end

  def destroy
    @pet = Pet.find_by_id(params[:pet_id])
    @pictures = Picture.find_by_id(params[:id])
    if current_user == @pet.user
      @pictures.destroy
      redirect_to user_pets_path(current_user)
    else
      flash[:notice]="You are not authorized to delete this picture!"
      redirect_to user_pets_path(current_user)
    end
  end


  private
  def pet_pictures
    Picture.find(pet_id:@pet.id)
  end

  def picture_params
    params.require(:picture).permit(:photo, :title)
  end

  def pet_params
    params.require(:pet).permit(:name, :gender, :breed, :weight, :bio, :pet_avatar)
  end

end
