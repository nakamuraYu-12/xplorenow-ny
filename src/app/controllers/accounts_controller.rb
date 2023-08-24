class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :profile, :profile_edit, :profile_update]
  before_action :check_guest_user, only: [:show, :profile, :profile_edit, :prifile_update]

  def show
  end

  def profile
  end

  def profile_edit
    # @user = current_userにしていない理由ってありますか？？
    @user = User.find(current_user.id)
  end

  def profile_update
    @user = User.find(current_user.id)
    if @user.update(params.require(:user).permit(:name, :profile, :image))
      flash[:success] = "プロフィールを編集しました"
      redirect_to "/accounts/profile"
    else
      flash[:error] = "プロフィール編集に失敗しました"
      # renderを使用するなら
      # render :profile_edit
      # の方が良さそうです。
      # render は同じアクション内でビューを表示するために使用し、redirect_to は異なるURLにユーザーをリダイレクトするために使用します。
      render "/accounts/profile_edit"
    end
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def user
    # @user = User.includes(events:[:event_dates]).find(params[:id])
    # にすると
    # @events = @user.events.order(:created_at)
    # とincludesを2回書かずに済みます
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
