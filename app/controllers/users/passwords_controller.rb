# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def ensure_normal_user
    sample_email = ['test1@test', 'test2@test', 'test3@test', 'test4@test', 'guest@example.com']
    if sample_email.include?(params[:user][:email].downcase)
      redirect_to new_user_session_path, alert: 'ゲストユーザー・サンプルユーザーのパスワード再設定はできません。'
    end
  end
end
