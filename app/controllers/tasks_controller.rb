class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.room_id = current_user.room_id
    @task.creator_id = current_user.id
    if @task.save!
      flash[:notice] = '新規タスクを作成しました。'
      redirect_to tasks_path
    else
      flash.now[:error] = '入力項目を見直してください。'
      render :new
    end
  end

  def index
    @tasks = Task.where(room_id: current_user.room_id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end


  private

  def task_params
    params.require(:task).permit(:body, :due_date, :genre_id)
  end
end
