class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @discussion = Discussion.find params[:discussion_id]
    project = @discussion.project
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.discussion = @discussion
    if @comment.save
      redirect_to project_discussion_path(project, @discussion)
    else
      render "/projects/discussions/show"
    end
  end

  def destroy
    discussion = Discussion.find params[:discussion_id]
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to project_discussion_path(discussion.project, discussion), alert: "Comment Deleted!"
  end

end
