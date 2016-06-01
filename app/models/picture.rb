class Picture < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :pet
end
