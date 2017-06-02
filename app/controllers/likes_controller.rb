class LikesController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource

  def create
    current_user.likes.create post: @post
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
