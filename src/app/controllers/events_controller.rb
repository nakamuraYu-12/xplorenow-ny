class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :history, :create, :edit, :update]

  def new
    @event = Event.new
    @event_dates = @event.event_dates.build
  end

  def create
    @result = MapQuery.new(params[:event][:address]).result
    if @result.nil?
      flash.now[:warning] = "イベントの登録に失敗しました"
      @event = Event.new(event_params)
      @event.validate
      @event.errors.add(:base, "有効な住所を入力してください")
      render "events/new"
      return
    end

    event_params_with_coordinates = event_params.merge(latitude: @result["lat"], longitude: @result["lng"])
    @event = Event.new(event_params_with_coordinates)
    tag_list = params[:event][:tag_name].split(',')

    if @event.save
      @event.save_event_tags(tag_list)
      flash[:success] = "イベントを登録しました"
      redirect_to "/"
    else
      flash[:warning] = "イベントの登録に失敗しました"
      render "events/new"
    end
  end

  def edit
    @event = Event.includes(:event_dates).find(params[:id])
    @tag_list = @event.tags.pluck(:name).join(',')
  end

  def update
    @event = Event.includes(:event_dates).find(params[:id])
    @result = MapQuery.new(params[:event][:address]).result
    tag_list = params[:event][:tag_name].split(',')
    if @result.nil?
      flash.now[:warning] = "イベントの更新に失敗しました"
      @event.errors.add(:address, "有効な住所を入力してください")
      render "events/edit"
      return
    end
    event_params_with_coordinates = event_params.merge(latitude: @result["lat"], longitude: @result["lng"])
    if @event.update(event_params_with_coordinates)
      @event.save_event_tags(tag_list)
      flash[:success] = "イベントを編集しました"
      redirect_to @event
    else
      flash[:warning] = "イベントの編集に失敗しました"
      render :edit
    end
  end

  def index
    @hide_footer = true
    @events = Event.includes(:event_dates, :tags).order("events.created_at DESC")
    @all_tags = Tag.where(id: EventTag.pluck(:tag_id).uniq)
    @event_dates = []
    current_day = Date.today
    current_time = Time.now

    @events.each do |event|
      event_dates = event.event_dates.order(:event_day)
      current_date = event_dates.find { |ed| ed.event_day == current_day && is_time_feature(ed.end_time, current_time) }
      feature_date = event_dates.find { |ed| ed.event_day > current_day  }
      past_date = event_dates.reverse.find do |ed|
        ed.event_day < current_day ||
          ed.event_day == current_day && is_time_past(ed.end_time, current_time)
      end
      selected_date = current_date || feature_date || past_date
      @event_dates << {
        event_id: event.id,
        selected_date: selected_date,
      }
    end

    if current_user
      @bookmark_events = current_user.bookmarks_events.includes(:user).order(created_at: :desc)
    else
      @bookmark_events = []
    end
  end

  def show
    @event = Event.includes(:event_dates, :tags).find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "イベントを削除しました"
    redirect_to "/"
  end

  def history
    @events = Event.includes(:event_dates).where(user_id: current_user.id).order("events.created_at DESC")
    @hide_footer = true
    if current_user
      @bookmark_events = current_user.bookmarks_events.includes(:user).order(created_at: :desc)
    else
      @bookmark_events = []
    end
  end

  def delete_image
    @event = Event.find(params[:id])
    @event.remove_image = '1'
    @event.save
    redirect_to edit_event_path(@event), notice: '画像が削除されました。'
  end

  def is_same_day(date1, date2)
    date1.year === date2.year &&
    date1.month === date2.month &&
    date1.day === date2.day
  end

  def is_time_feature(time1, time2)
    time1.hour > time2.hour || (time1.hour === time2.hour && time1.min > time2.min)
  end

  def is_time_past(time1, time2)
    time1.hour < time2.hour || (time1.hour == time2.hour && time1.min < time2.min)
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :introduction, :address, :image, :remove_image, :user_id, :tag_list,
      event_dates_attributes: [:id, :start_time, :end_time, :event_day, :_destroy]
    )
  end
end
