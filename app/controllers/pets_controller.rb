class PetsController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end
end
