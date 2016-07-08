class MembersController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find params[:project_id]
    member = Member.new(project: project, user: current_user)
    # member.project = project
    if member.save
      redirect_to project_path(project), notice: "Joined!"
    else
      redirect_to project_path(project), alert: "Can't Join!"
    end
  end

  def destroy
    member = Member.find params[:id]
    project = Project.find params[:project_id]
    member.destroy
    redirect_to project_path(project), notice: "Un-joined!"
  end

end
