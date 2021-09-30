class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:task_id])
    @message = Message.new(message_params)
    @message.task_id = @task.id
    @message.user_id = current_user.id
    if @message.save
      @message.task.create_notification_message!(current_user, @message.id, @task.id)
      @message = Message.new
    else
      render 'error'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
