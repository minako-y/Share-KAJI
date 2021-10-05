class TemplateTasksController < ApplicationController
  def destroy
    template_task = TemplateTask.find(params[:id])
    template_task.destroy
    flash.now[:notice] = 'テンプレートタスクを一件削除しました。'
    @template_tasks = TemplateTask.template_task_list(session[:room_id], current_user.id, params[:page])
    @tag_list = Tag.template_task_tag_used_in_room(session[:room_id], current_user.id)
  end
end
