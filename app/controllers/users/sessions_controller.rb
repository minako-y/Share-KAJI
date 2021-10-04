# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    room = Room.find_by(name: '1LDK')
    log_in room
    user.current_room_id = room.id
    user.save
    # 中間テーブルに登録済みかを確認し、データがない場合登録する
    user_room = UserRoom.where(user_id: user.id, room_id: room.id)
    if user_room.empty?
      user_room = UserRoom.new(user_id: user.id, room_id: room.id)
      user_room.save
    end
    redirect_to mypage_path, notice: 'ゲストユーザーとしてログインしました。「タスク管理」よりルームへ入室できます。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for
    mypage_path
  end

  def after_sign_out_path_for
    root_path
  end

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    return unless @user

    return unless @user.valid_password?(params[:user][:password]) && @user.is_deleted

    flash[:alert] = '退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
    redirect_to new_user_session_path
  end
end
