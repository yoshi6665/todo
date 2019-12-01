class TasksController < ApplicationController
  def new
    @task=Task.new
  end

  def index
    status_ids=[0,2,1]
    @tasks= current_user.tasks.all.order(params[:sort])
  end

  def show
    @task=Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.status = "未着手"

    if @task.save
      redirect_to tasks_path, success: '保存しました'
    else
      flash.now[:danger]="保存に失敗しました"
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    if @task.save
      redirect_to task_path, success: '保存しました'
    else
      flash.now[:danger] = "保存に失敗しました"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path ,success: '削除しました'
  end

  def start
    @task = Task.find(params[:id])
    @task.status = '処理中'
    @task.start_date = Date.today
    @task.save
    redirect_to task_path(id: params[:id]) ,success: '作業を開始しました'
  end

  def finish
    @task = Task.find(params[:id])
    @task.status = '完了'
    @task.finish_date = Date.today
    @task.save
    redirect_to task_path(id: params[:id]) ,success: '作業を終了しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :finish_schedule_date, :priority, :status)
  end

end
