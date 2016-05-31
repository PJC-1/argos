class Pet < ActiveRecord::Base
  mount_uploader :pet_avatar, PetAvatarUploader
  
  belongs_to :user
end
