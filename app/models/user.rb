class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_secure_password
  has_many :events
  has_many :pets
end
