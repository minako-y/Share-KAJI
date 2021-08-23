class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_room
  before_action :set_new_messages, only: [:index, :show, :update, :search]

  def new
    # テンプレートから参照しているか確認
    if params[:template].nil?
      @task = Task.new
    else
      template_task = TemplateTask.find(params[:template])
      @task = Task.new(genre_id: template_task.genre_id, body: template_task.body, tag_name: template_task.tags.pluck(:name).join(" "))
    end
    # 他人の個人テンプレタスクが表示されないようにする
    @template_tasks = TemplateTask.where(room_id: session[:room_id]).where.not(genre_id: 7).or(TemplateTask.where(user_id: current_user.id, genre_id: 7))
    @tag_list = Tag.joins(:template_tasks).distinct.where(template_tasks: {room_id: session[:room_id]})
                                          .where.not(template_tasks: {genre_id: 7})
                                          .or(Tag.joins(:template_tasks).distinct.where(template_tasks: {user_id: current_user.id, genre_id: 7}))
  end

  def create
    @task = Task.new(task_params)
    @task.room_id = session[:room_id]
    @task.creator_id = current_user.id
    # モンスターをタスクと紐付ける
    @monster = Monster.monster_choice(current_user, @task.genre)
    @task.monster_id = @monster.id
    tag_list = @task.tag_name.split(/[[:space:]]/)
    if @task.save
      @task.save_tags(tag_list)
      # テンプレートタスクへの保存
      if @task.template_task == "true"
        template_task = TemplateTask.new(
          user_id: current_user.id,
          room_id: @task.room_id,
          body: @task.body,
          genre_id: @task.genre_id
          )
        template_task.save
        template_task.save_tags(tag_list)
        flash[:notice] = 'テンプレートタスクへ保存しました。'
      end
      flash[:notice] = '新規タスクを作成しました。'
      redirect_to tasks_path
    else
      @template_tasks = TemplateTask.where(room_id: session[:room_id]).where.not(genre_id: 7).or(TemplateTask.where(user_id: current_user.id, genre_id: 7))
      @tag_list = Tag.joins(:template_tasks).distinct.where(template_tasks: {room_id: session[:room_id]})
                                          .where.not(template_tasks: {genre_id: 7})
                                          .or(Tag.joins(:template_tasks).distinct.where(template_tasks: {user_id: current_user.id, genre_id: 7}))
      flash.now[:alert] = '入力項目を見直してください。'
      render :new
    end
  end

  def index
    @tasks = Task.where(room_id: session[:room_id], progress: (params[:sort] || 0))
    @tag_list = Tag.joins(:tasks).distinct.where(tasks: {room_id: session[:room_id], progress: (params[:sort] || 0)})
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
    @task.tag_name = @task.tags.pluck(:name).join(" ")
  end

  def update
    @task = Task.find(params[:id])
    tag_list = @task.tag_name.split(/[[:space:]]/)
    if @task.update(task_params)
      @task.save_tags(tag_list)
      if @task.progress == "完了"
        @task.update(executor_id: current_user.id, finish_date: Time.now)
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

  def search_task
    @tag = Tag.find(params[:tag_id])
    @tasks = @tag.tasks.where(room_id: session[:room_id], progress: (params[:sort] || 0))
    @tag_list = Tag.joins(:tasks).distinct.where(tasks: {room_id: session[:room_id], progress: (params[:sort] || 0)})
  end

  def search_template_task
    @tag = Tag.find(params[:tag_id])
    @template_tasks = @tag.template_tasks.where(room_id: session[:room_id]).where.not(genre_id: 7).or(@tag.template_tasks.where(user_id: current_user.id, genre_id: 7))
    @tag_list = Tag.joins(:template_tasks).distinct.where(template_tasks: {room_id: session[:room_id]})
                                          .where.not(template_tasks: {genre_id: 7})
                                          .or(Tag.joins(:template_tasks).distinct.where(template_tasks: {user_id: current_user.id, genre_id: 7}))
  end


  private

  def logged_in_room
    unless logged_in?
      flash[:alert] = "ログインが必要です。"
      redirect_to login_path
    end
  end

  def task_params
    params.require(:task).permit(:body, :due_date, :genre_id, :progress, :template_task, :tag_name)
  end

  def set_new_messages
    @message = Message.new
  end
end
