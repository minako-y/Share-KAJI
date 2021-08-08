class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      # 中間テーブルにより関連付けされる
      user_room = UserRoom.new(user_id: current_user.id, room_id: @room.id)
      user_room.save
      # マイルームへ登録
      current_user.update(room_id: @room.id)
      # 作成したルームへ遷移
      flash[:notice] = "新しいルームが作成されました。"
      redirect_to tasks_path(@room.id)
    else
      flash.now[:error] = "ルーム名・パスワードを正しく設定してください。"
      render :new
    end
  end

  def search
  end


  def show　#ルーム検索結果を表示する

  end



  private

  def room_params
    params.require(:room).permit(:name, :room_password)
  end
end
