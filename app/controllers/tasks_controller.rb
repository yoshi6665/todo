class TasksController < ApplicationController
  before_action :set_task, except: [:new, :create, :index]

  def new
    @task = Task.new
  end

  def index
    prepare_search_attr
    @statuses = Task.statuses
    @priorities = Task.priorities
    @tasks = Task.search(@search_attr)
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.status = Task.statuses["未着手"]

    if @task.save
      redirect_to tasks_path, success: '保存しました'
    else
      flash.now[:danger] = "保存に失敗しました"
      redirect_to new_task_path
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    if @task.save!
      redirect_to task_path, success: '保存しました'
    else
      flash.now[:danger] = "保存に失敗しました"
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, success: '削除しました'
  end

  def start
    @task.status = Task.statuses["作業中"]
    @task.start_date = Date.today
    @task.save
    redirect_to task_path(id: params[:id]) ,success: '作業を開始しました'
  end

  def finish
    @task.status = Task.statuses["完了"]
    @task.finish_date = Date.today
    @task.save
    redirect_to task_path(id: params[:id]) ,success: '作業を終了しました'
  end

  private
  def prepare_search_attr
    @search_attr = {search:'', status:'', priority:'', start_from: '',start_to: '',finish_schedule_from: '',finish_schedule_to: '',sort: '',updown: ''}
    @search_attr = task_params.delete_if { |_key, val| val.blank? } if params.key?(:task)
  end

  def task_params
    params.require(:task).permit(:title,:description,:keyword,:start_from,:start_to,:finish_schedule_from,:finish_schedule_to, :priority, :status,:sort,:updown)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
