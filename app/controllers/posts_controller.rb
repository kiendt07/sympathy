class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_post, only: [:show, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find_by id: params[:post_id]
    if @post
      new_post = current_user.posts.create content: @post.original_content
      redirect_to post_path new_post
    else
      flash[:danger] = t ".flash.danger"
      redirect_to post_path @post
    end
  end

  def show
    @comment = @post.comments.build
    @comments = @post.comments.new_first.includes :user
  end

  def destroy
    @post.content.destroy unless @post.content.is_post?
    if @post.destroy
      flash[:success] = t ".flash.success"
    else
      flash[:warning] = t ".flash.warning"
    end
    redirect_to home_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    redirect_to home_path unless @post
  end

  def correct_user
    flash[:danger] = t ".correct_user.flash.danger"
    redirect_to home_path unless current_user.id == @post.user.id
  end
end
