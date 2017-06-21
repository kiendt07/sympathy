class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      respond_to do |format|
        format.html{redirect_to @comment.post}
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :post_id
  end
end
