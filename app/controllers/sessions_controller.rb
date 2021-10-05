class SessionsController < ApplicationController
  def new
  end

  def create
    room = Room.find_by(name: params[:session][:name])
    if room&.authenticate(params[:session][:password])
      log_in room
      # 最後に入室したルームとしてマイページで確認可能にする
      user = User.find(current_user.id)
      user.current_room_id = session[:room_id]
      user.save
      # 中間テーブルに登録済みかを確認し、データがない場合登録する
      user_room = UserRoom.where(user_id: user.id, room_id: room.id)
      if user_room.empty?
        user_room = UserRoom.new(user_id: user.id, room_id: room.id)
        user_room.save
      end
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
