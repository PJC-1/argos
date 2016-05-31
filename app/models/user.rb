class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_secure_password
  has_many :pets
  has_many :events
end
