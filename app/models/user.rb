class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_secure_password

  acts_as_follower
  acts_as_followable

  has_many :events, dependent: :destroy
  has_many :pets, dependent: :destroy

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
end
