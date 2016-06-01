class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  acts_as_follower
  acts_as_followable

  has_secure_password
  has_many :events
  has_many :pets
end
