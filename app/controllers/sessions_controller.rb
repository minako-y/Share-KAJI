class SessionsController < ApplicationController
  def new
  end

  def create
    room = Room.find_by(name: params[:session][:name])
    if room && room.authenticate(params[:session][:password])
      log_in room
      redirect_to tasks_path
    else
      flash[:alert] = '名前またはパスワードが違います。'
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
