class Pet < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  mount_uploader :pet_avatar, PetAvatarUploader


  belongs_to :user
  has_many :pictures, dependent: :destroy
end
