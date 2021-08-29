class TemplateTasksController < ApplicationController

  def destroy
    template_task = TemplateTask.find(params[:id])
    template_task.destroy
    flash.now[:notice] = "テンプレートタスクを一件削除しました。"
    @template_tasks = TemplateTask.where(room_id: session[:room_id]).where.not(genre_id: 7).or(TemplateTask.where(user_id: current_user.id, genre_id: 7)).page(params[:page]).per(10)
    @tag_list = Tag.joins(:template_tasks).distinct.where(template_tasks: {room_id: session[:room_id]})
                                          .where.not(template_tasks: {genre_id: 7})
                                          .or(Tag.joins(:template_tasks).distinct.where(template_tasks: {user_id: current_user.id, genre_id: 7}))
  end
end
