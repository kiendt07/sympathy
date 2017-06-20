class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :correct_user, only: [:destroy]
  before_action :log_impression, only: :show

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

  def log_impression
    if user_signed_in?
      @post.original_content.impressions.create ip_address: request.remote_ip,
        user_id: current_user.id
      current_user.like @post.original_content
    else
      @post.original_content.impressions.create ip_address: request.remote_ip
    end
  end
end
