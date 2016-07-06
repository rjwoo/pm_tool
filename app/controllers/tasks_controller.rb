class TasksController < ApplicationController
before_action :task_params, only: [:create, :update]
before_action :find_tasks, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    task_params = params.require(:task).permit(:body)
    @task = Task.new task_params
    @project = Project.find params[:project_id]
    @task.project = @project
    if @task.save
      flash[:notice] = "Task created!"
      redirect_to project_path(@project)
    else
      flash[:alert] = "Was not able to create task!"
      render "/projects/show"
    end
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  def update
    if @task.update task_params
      redirect_to task_path(@task), notice: "Successfully deleted task!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:alert] = "Successfully deleted task!"
    redirect_to tasks_path
  end

  def undone
    @task = Task.find params[:id]
    @project = Project.find params[:project_id]
    @task.project = @project
    if @task.undone === 'Not Done'
      @task.update(undone: 'Done' )
    else
      @task.update(undone: 'Not Done')
    end
    redirect_to project_path(@project)
  end

  private

  def task_params
    task_params = params.require(:task).permit(:body, :undone)
  end

  def find_tasks
    @task = Task.find params[:id]
  end
end
