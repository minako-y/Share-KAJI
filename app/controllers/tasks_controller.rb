class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_room

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.room_id = session[:room_id]
    @task.creator_id = current_user.id
    # モンスターをタスクと紐付ける
    @monster = Monster.monster_choice(current_user, @task.genre)
    @task.monster_id = @monster.id
    if @task.save!
      # # テンプレートタスクへの保存
      # if params[:task][:template_task] == true
      #   template_task = TemplateTask.new(
      #     user_id: current_user_id,
      #     room_id: @task.room_id,
      #     body: @room.body,
      #     ganre_id: @room.genre_id)
      #   template_task.save
      #   flash[:notice] = 'テンプレートタスクへ保存しました。'
      # end
      flash[:notice] = '新規タスクを作成しました。'
      redirect_to tasks_path
    else
      flash.now[:alert] = '入力項目を見直してください。'
      render :new
    end
  end

  def index
    @tasks = Task.where(room_id: session[:room_id])
    @message = Message.new
  end

  def show
    @task = Task.find(params[:id])
    @message = Message.new
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
    @message = Message.new
    if @task.update(task_params)
      if @task.progress == "完了"
        current_user.taskCompleted(current_user, @task)
        return
      end
      redirect_to tasks_path
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

  def logged_in_room
    unless logged_in?
      flash[:alert] = "ログインが必要です。"
      redirect_to login_path
    end
  end

  def task_params
    params.require(:task).permit(:body, :due_date, :genre_id, :progress, :template_task)
  end
end
