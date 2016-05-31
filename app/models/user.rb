class User < ActiveRecord::Base
  has_secure_password
  has_many :pets
  has_many :events
end
