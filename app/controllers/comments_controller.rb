class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @discussion = Discussion.find params[:discussion_id]
    project = @discussion.project
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.discussion = @discussion
    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_discussion_owner(@comment).deliver_now
        format.html  { redirect_to project_discussion_path(project, @discussion) }
        format.js    { render :create_success }
      else
        format.html  { render "/projects/discussions/show" }
        format.js    { render :create_failure }
      end
    end
  end

  def destroy
    discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
    comment.destroy
    respond_to do |format|
      format.html { redirect_to project_discussion_path(discussion.project, discussion), alert: "Comment Deleted!" }
      format.js   { render }
    end
  end

end
