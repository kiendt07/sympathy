class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :correct_user, only: [:destroy]

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

  def correct_user
    flash[:danger] = t ".correct_user.flash.danger"
    redirect_to home_path unless current_user.id == @post.user.id
  end
end
