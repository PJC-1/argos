class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

private

  def authorize
    redirect_to login_path, alert: "Not authorized" if current_user == nil
  end

end
