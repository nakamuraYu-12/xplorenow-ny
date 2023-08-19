class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :history, :create, :edit, :update]

  def new
    @user = User.find(current_user.id)
    @event = Event.new
    @event_dates = @event.event_dates.build
  end

  def create
    @user = User.find(current_user.id)
    @result = MapQuery.new(params[:event][:address]).result

    if @result.nil?
      flash.now[:warning] = "イベントの登録に失敗しました"
      @event = Event.new(event_params)
      @event.errors.add(:address, "有効な住所を入力してください")
      render "events/new"
      return
    end

    event_params_with_coordinates = event_params.merge(latitude: @result["lat"], longitude: @result["lng"])
    @event = Event.new(event_params_with_coordinates)

    if @event.save
      flash[:success] = "イベントを登録しました"
      redirect_to "/"
    else
      flash[:warning] = "イベントの登録に失敗しました"
      render "events/new"
    end
  end

  def edit
    puts "params[:id] = #{params[:id]}"
    @user = User.find(current_user.id)
    @event = Event.includes(:event_dates).find(params[:id])
  end

  def update
    @event = Event.includes(:event_dates).find(params[:id])
    if @event.update(event_params)
      flash[:success] = "イベントを編集しました"
      redirect_to @event
    else
      flash[:warning] = "イベントの編集に失敗しました"
      render :edit
    end
  end

  def index
    @events = Event.includes(:event_dates).order("events.created_at DESC")
  end

  def show
    @event = Event.includes(:event_dates).find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "イベントを削除しました"
    redirect_to "/"
  end

  def history
    @events = Event.includes(:event_dates).where(user_id: current_user.id).order("events.created_at DESC")
  end

  def delete_image
    @event = Event.find(params[:id])
    @event.remove_image = '1'
    @event.save
    redirect_to edit_event_path(@event), notice: '画像が削除されました。'
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :introduction, :address, :image, :remove_image,
      event_dates_attributes: [:id, :start_time, :end_time, :event_day, :_destroy]
    )
  end
end
