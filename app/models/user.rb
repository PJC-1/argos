class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_secure_password

  acts_as_follower
  acts_as_followable

  has_many :events, dependent: :destroy
  has_many :pets, dependent: :destroy

  validates :email, presence: true, uniqueness: true, length: { minimum: 6 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :create


  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
end
