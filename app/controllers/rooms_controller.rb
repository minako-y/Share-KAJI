class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
    @user_rooms = current_user.rooms
  end

  def create
    @room = Room.new(room_params)
    if @room.save!
      # 中間テーブルにより関連付けされる
      user_room = UserRoom.new(user_id: current_user.id, room_id: @room.id)
      user_room.save
      # マイルームへ登録
      current_user.update(current_room_id: @room.id)
      # 作成したルームへ遷移
      flash[:notice] = "新しいルームが作成されました。"
      redirect_to tasks_path
    else
      flash.now[:alert] = "ルーム名・パスワードを正しく設定してください。"
      render :new
    end
  end

  def search
    if Room.where(id: params[:room_search].to_i).exists?
      redirect_to room_path(params[:room_search].to_i)
    else
      flash[:alert] = "ルームが見つかりません。"
      redirect_to new_room_path
    end
  end

  def show　#ルーム検索結果を表示する
    @room = Room.find(params[:id])
  end


  private

  def room_params
    params.require(:room).permit(:name, :password)
  end
end
