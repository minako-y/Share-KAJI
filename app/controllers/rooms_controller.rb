class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
    @user_rooms = current_user.rooms
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      # 中間テーブルにより関連付けされる
      user_room = UserRoom.new(user_id: current_user.id, room_id: @room.id)
      user_room.save
      # マイルームへ登録
      current_user.update(current_room_id: @room.id)
      # 初回セッションは自動作成
      log_in @room
      # 最後に入室したルームとしてマイページで確認可能にする
      user = User.find(current_user.id)
      user.current_room_id = session[:room_id]
      user.save
      # 作成したルームへ遷移
      flash[:notice] = "新しいルームが作成されました。"
      redirect_to tasks_path
    else
      flash.now[:alert] = "ルーム名・パスワードを正しく設定してください。"
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :password)
  end
end
