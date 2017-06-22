class LikesController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource

  def create
    @like = current_user.real_likes.create post: @post
    push_notification @like.notification, @like.post.user unless
      @like.post.user.id == current_user.id
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = @like.post
    @like.destroy
    respond_to do |format|
      format.js
    end
  end
end
