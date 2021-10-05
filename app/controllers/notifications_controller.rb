class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = if params[:sort] == 'checked'
                       current_user.passive_notifications.where(checked: true)
                     else
                       current_user.passive_notifications.where(checked: false)
                     end
  end

  def update
    @notifications = current_user.passive_notifications.where(checked: false)
    @notification = Notification.find(params[:id])
    @notification.update(checked: true)
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
