class MonstersController < ApplicationController
  before_action :authenticate_user!
  before_action :monster_set, only: [:show, :edit, :update, :destroy]
  before_action :edit_authority, only: [:edit, :update, :destroy]
  def create
    @monster = Monster.new(monster_params)
    @monster.user_id = current_user.id
    @monster.official = false
    if @monster.save
      flash[:notice] = "新しいモンスターが誕生しました！"
      redirect_to monsters_path
    else
      @monsters =  Monster.where(user_id: current_user.id).or(Monster.where(official: true))
      flash.now[:alert] = "入力情報に不備があります。"
      render :index
    end
  end

  def index
    @monster = Monster.new
    @monsters = Monster.where(user_id: current_user.id).or(Monster.where(official: true)).order(monster_id: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @monster.update(monster_params)
      flash[:notice] = "情報を更新しました。"
      redirect_to monsters_path
    else
      flash.now[:alert] = "入力情報に不備があります。"
      render :edit
    end
  end

  def destroy
    @monster.destroy
    flash[:alert] = "モンスターを削除しました。"
    redirect_to monsters_path
  end

  private

  def monster_params
    params.require(:monster).permit(:genre_id, :image, :name, :memo)
  end

  def monster_set
    @monster = Monster.find(params[:id])
  end

  def edit_authority
    unless @monster.user_id == current_user.id
      flash[:alert] = "該当モンスターの編集権限がありません。"
      redirect_to monsters_path
    end
  end
end
