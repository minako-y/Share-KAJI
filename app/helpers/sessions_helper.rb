module SessionsHelper
  # ブラウザ内の一時cookiesに暗号化済みのroomIDを格納
  def log_in(room)
    session[:room_id] = room.id
  end

  def log_out
    session.delete(:room_id)
    @current_room = nil
  end

  # ログインしているユーザーのルームを表示
  def current_room
    if session[:room_id]
      @current_room ||= Room.find_by(id: session[:room_id])
    end
  end

  # ログインしているかどうか判断する
  def logged_in?
    !current_room.nil?
  end
end
