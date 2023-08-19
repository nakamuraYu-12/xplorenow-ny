class BookmarksController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.bookmark(event)
    redirect_back fallback_location: root_path, success: 'ブックマークしました'
  end

  def destroy
    event = current_user.bookmarks.find_by(params[:event_id]).event
    current_user.unbookmark(event)
    redirect_back fallback_location: root_path, success: 'ブックマークを外しました'
  end

  def bookmarks
    @bookmark_events = current_user.bookmarks_events.includes(:user).order(created_at: :desc)
  end
end
