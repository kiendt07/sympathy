class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.paginate page: params[:page]
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.new_first.includes(:user)
  end
end
