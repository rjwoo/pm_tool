class ProjectsController < ApplicationController
before_action :project_params, only: [:create, :update]
before_action :find_projects, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:notice] = "Project Created!"
      redirect_to project_path(@project)
    else
      flash[:alert] = "Was not able to create project!"
      render :new
    end
  end

  def index
    @projects = Project.all
  end

  def show
    @discussion = Discussion.new
    @task = Task.new
    @favourite = @project.favourite_for(current_user)
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to project_path(@project), notice: "Successfully deleted project!"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:alert] = "Successfully deleted project!"
    redirect_to projects_path
  end

  private

  def project_params
    project_params = params.require(:project).permit(:title, :description, :due_date)
  end

  def find_projects
    @project = Project.find params[:id]
  end
end
