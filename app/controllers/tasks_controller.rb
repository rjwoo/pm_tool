class TasksController < ApplicationController
before_action :task_params, only: [:create, :update]
before_action :find_tasks, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    if @task.save
      flash[:notice] = "Task created!"
      redirect_to task_path(@task)
    else
      flash[:alert] = "Was not able to create task!"
      render :new
    end
  end

  def index
    @task = Task.all
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

  private

  def task_params
    task_params = params.require(:task).permit(:title, :due_date)
  end

  def find_tasks
    @task = Task.find params[:id]
  end
end
