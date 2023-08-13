class EventsController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @event = Event.new
    @event_dates = @event.event_dates.build
  end

  def create
    @user = User.find(current_user.id)
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "イベントを登録しました"
      redirect_to "/"
    else
      flash[:warning] = "イベントの登録に失敗しました"
      render "events/new"
    end
  end

  def index
  end

  def show
  end

  private
    def event_params
      params.require(:event).permit(
        :name, :introduction, :address, :image, :user_id,
        event_dates_attributes: [ :id, :event_id, :event_day, :start_time, :end_time, :_destroy ])
        .merge(user_id: current_user.id)
    end
end
