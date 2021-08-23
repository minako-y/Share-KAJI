class UsersController < ApplicationController
  before_action :set_current_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "アカウント情報が更新されました。"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :weaknesses_genre_id)
  end

  def set_current_user
    @user = current_user
  end
end
