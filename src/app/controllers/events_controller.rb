class EventsController < ApplicationController
  def new
    @user = User.find(current_user.id)
  end

  def index
  end

  def show
  end

end
