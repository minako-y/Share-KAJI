class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:sort] == "checked"
      @notifications = current_user.passive_notifications.where(checked: true).page(params[:page]).per(10)
    else
      @notifications = current_user.passive_notifications.where(checked: false).page(params[:page]).per(10)
    end
  end

  def update
    @notifications = current_user.passive_notifications.where(checked: false).page(params[:page]).per(10)
    @notification = Notification.find(params[:id])
    @notification.update(checked: true)
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
