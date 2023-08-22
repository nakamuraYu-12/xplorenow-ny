class UsersController < ApplicationController
  before_action :authenticate_user!

  def unsubscribe
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "アカウント削除を実行いたしました"
    redirect_to root_path
  end
end
