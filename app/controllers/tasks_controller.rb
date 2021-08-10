class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.room_id = current_user.current_room_id
    @task.creator_id = current_user.id
    if @task.save
      flash[:notice] = '新規タスクを作成しました。'
      redirect_to tasks_path
    else
      flash.now[:alert] = '入力項目を見直してください。'
      render :new
    end
  end

  def index
    @tasks = Task.where(room_id: current_user.current_room_id)
  end

  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html
      # link_toメソッドをremote: trueに設定したのでリクエストはjs形式で行われる
      format.js
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      flash.now[:alert] = "入力項目を見直してください。"
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice] = "正常に削除されました。"
    redirect_to tasks_path
  end


  private

  def task_params
    params.require(:task).permit(:body, :due_date, :genre_id, :progress)
  end

end
