class UsersController < ApplicationController
  before_action :set_current_user
  before_action :ensure_normal_user, only: [:withdraw]

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

 # ゲストユーザー・サンプルユーザーの退会を防止する
  def ensure_normal_user
    sample_email = ['test1@test','test2@test','test3@test','test4@test','guest@example.com']
    if sample_email.include?(current_user.email)
      redirect_to user_path(current_user), alert: 'ゲストユーザー・サンプルユーザーは退会できません。'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :weaknesses_genre_id)
  end

  def set_current_user
    @user = current_user
  end
end
