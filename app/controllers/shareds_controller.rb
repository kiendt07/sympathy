class SharedsController < ApplicationController
  load_and_authorize_resource :post

  def create
    @shared_post = current_user.posts.create content: @post.original_post
    redirect_to post_path @shared_post
  end
end
