class TasksController < ApplicationController
  before_action :authenticate_user!, :logged_in_room
  before_action :set_new_messages, only: [:index, :show, :change_progress, :search]
  before_action :set_task, only: [:show, :edit, :update, :change_progress, :destroy]

  def new
    # テンプレートから参照しているか確認
    if params[:template].nil?
      @task = Task.new
    else
      template_task = TemplateTask.find(params[:template])
      @task = Task.new(genre_id: template_task.genre_id, body: template_task.body,
                       tag_name: template_task.tags.pluck(:name).join(' '))
    end
    # テンプレートタスクの一覧表示
    @template_tasks = TemplateTask.template_task_list(session[:room_id], current_user.id, params[:page])
    # テンプレートタスクのタグ一覧
    @tag_list = Tag.template_task_tag_used_in_room(session[:room_id], current_user.id)
  end

  def create
    @task = Task.new(task_params)
    @task.room_id = session[:room_id]
    @task.creator_id = current_user.id
    # モンスターをタスクと紐付ける
    @monster = Monster.monster_choice(current_user, @task.genre)
    @task.monster_id = @monster.id
    # タグを抽出
    tag_list = @task.tag_name.split(/[[:space:]]/)
    if @task.save
      # タグを保存
      @task.save_tags(tag_list)
      @task.create_notification_task!(current_user, 'created_task')
      # テンプレートタスクへ保存
      if @task.template_task == 'true'
        TemplateTask.create_template_task(@task, current_user, tag_list)
      end
      flash[:notice] = '新規タスクを作成しました。'
      redirect_to tasks_path
    else
      @template_tasks = TemplateTask.template_task_list(session[:room_id], current_user.id, params[:page])
      @tad_list = Tag.template_task_tag_used_in_room(session[:room_id], current_user.id)
      flash.now[:alert] = '入力項目を見直してください。'
      render :new
    end
  end

  def index
    @tasks = Task.where(room_id: session[:room_id],
                        progress: (params[:sort] || 0)).order(updated_at: :desc).page(params[:page]).per(10)
    @tag_list = Tag.task_tag_used_in_room(session[:room_id], params[:sort] || 0)
  end

  def show
    respond_to do |format|
      format.html { redirect_to tasks_path }
      # link_toメソッドをremote: trueに設定したのでリクエストはjs形式で行われる
      format.js
    end
  end

  def edit
    @task.tag_name = @task.tags.pluck(:name).join(' ')
  end

  def update
    if @task.update(task_params)
      tag_list = @task.tag_name.split(/[[:space:]]/)
      @task.save_tags(tag_list)
      flash[:notice] = 'タスクを更新しました。'
      redirect_to tasks_path
    else
      flash.now[:alert] = '入力項目を見直してください。'
      render :edit
    end
  end

  def change_progress
    @task.update(task_params)
    return unless @task.progress == '完了'

    @task.update(executor_id: current_user.id, finish_date: Time.now)
    current_user.task_completed(current_user, @task)
    @task.create_notification_task!(current_user, 'finished_task')
  end

  def destroy
    @task.destroy
    flash[:notice] = '正常に削除されました。'
    redirect_to tasks_path
  end

  def search_task
    @tag = Tag.find(params[:tag_id])
    @tasks = @tag.tasks.where(room_id: session[:room_id], progress: (params[:sort] || 0)).page(params[:page]).per(10)
    @tag_list = Tag.task_tag_used_in_room(session[:room_id], params[:sort] || 0)
  end

  def search_template_task
    if params[:tag_id].nil?
      @tag = Tag.new(id: 0)
      @template_tasks = TemplateTask.template_task_list(session[:room_id], current_user.id, params[:page])
    else
      @tag = Tag.find(params[:tag_id])
      @template_tasks = @tag.template_tasks.where(room_id: session[:room_id]).where.not(genre_id: 7)
                            .or(@tag.template_tasks.where(user_id: current_user.id,
                                                          genre_id: 7)).page(params[:page]).per(10)
    end
    @tag_list = Tag.template_task_tag_used_in_room(session[:room_id], current_user.id)
  end

  private

  def logged_in_room
    return if logged_in?

    flash[:alert] = 'ログインが必要です。'
    redirect_to login_path
  end

  def task_params
    params.require(:task).permit(:body, :due_date, :genre_id, :progress, :template_task, :tag_name)
  end

  def set_new_messages
    @message = Message.new
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
