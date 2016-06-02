class Picture < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, model) { controller && controller.current_user }
  mount_uploader :photo, PhotoUploader
  belongs_to :pet
end
