class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.following_users.ids, owner_type: "User").paginate(:page => params[:page], :per_page => 5)
  end
end
