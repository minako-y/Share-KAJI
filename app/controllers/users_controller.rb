class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(current_user.id)
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


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :weaknesses_genre_id)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
