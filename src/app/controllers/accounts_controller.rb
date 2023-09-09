class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :profile, :profile_edit, :profile_update]
  before_action :check_guest_user, only: [:show, :profile, :profile_edit, :prifile_update]

  def show
  end

  def profile
  end

  def profile_edit
  end

  def profile_update
    if @user.update(params.require(:user).permit(:name, :profile, :image))
      flash[:success] = "プロフィールを編集しました"
      redirect_to "/accounts/profile"
    else
      flash[:error] = "プロフィール編集に失敗しました"
      render :profile_edit
    end
  end

  def set_user
  end

  def user
    @hide_footer = true
    @user = User.includes(:events).find(params[:id])
    @events = @user.events.includes(:event_dates).order("events.created_at DESC")
  end

  def check_guest_user
    if @user.email == "guest@example.com"
      flash[:alert] = "ゲストユーザーはプロフィール詳細は閲覧できません"
      redirect_to "/"
    end
  end
end
