class ImpressionsController < ApplicationController
  def create
    @post = Post.find params[:post_id]
    if user_signed_in?
      @post.original_content.impressions.create ip_address: request.remote_ip,
       user_id: current_user.id
      current_user.like @post.original_content
    else
      @post.original_content.impressions.create ip_address: request.remote_ip
    end
  end
end
