class EventsController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
    @events = @user.events.all
    @events_by_date = @events.group_by(&:published_on)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @event = Event.new
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def create
   user = User.find(params[:user_id])
   new_event = Event.new(event_params)
   if new_event.save
     user.events << new_event
     redirect_to user_event_path(user, new_event)
   else
     flash[:error] = new_event.errors.full_messages.join(", ")
     redirect_to new_user_event_path(user)
   end
  end

  def show
    event_id = params[:id]
    @event = Event.find_by(id: event_id)
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def edit
    event_id = params[:id]
    @event = Event.find_by(id: event_id)
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def update
    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    event_id = params[:id]
    event = Event.find_by(id: event_id)

    if event.update(event_params)
      flash[:notice] = "Updated successfully."
      redirect_to user_event_path(user, event)
    else
      flash[:error] = event.errors.full_messages.join(", ")
      redirect_to edit_user_event_path(user, event)
    end
  end

  def destroy
    event_id = params[:id]
    event = Event.find_by(id: event_id)
    event.delete

    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    redirect_to user_events_path(user)
  end

  private
  def event_params
    params.require(:event).permit(:name, :published_on, :content)
  end
end
