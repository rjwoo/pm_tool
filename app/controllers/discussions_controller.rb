class DiscussionsController < ApplicationController

  def create
    @project = Project.find params[:project_id]
    discussion_params = params.require(:discussion).permit(:title, :body)
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    if @discussion.save
      redirect_to project_path(@project), notice: "Discussion Created"
    else
      render "/projects/show"
    end
  end

  def destroy
    project = Project.find params[:project_id]
    discussion = Discussion.find params[:id]
    discussion.destroy
    redirect_to project_path(project), notice: "Discussion Deleted!"
  end

end