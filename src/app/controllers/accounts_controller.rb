class AccountsController < ApplicationController
  def show
  end

  def profile
  end

  def profile_edit
    @user = User.find(current_user.id)
  end

  def profile_update
    @user = User.find(current_user.id)
    @user.update(params.require(:user).permit(:name,:profile,:image))
    redirect_to "/accounts/profile"
  end
end
