class CommentsMailer < ApplicationMailer

  def notify_discussion_owner(comment)
    @user = comment.user
    @discussion = comment.discussion
    mail(to: @discussion.user.email, subject: "#{@user.full_name} commented on your discussion.")
  end

end
