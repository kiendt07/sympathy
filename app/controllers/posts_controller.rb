class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    case params[:type]
    when "track"
      create_track_post
    when "post"
      create_post
    when "playlist"
      create_playlist_post
    end
  end

  def show
  end

  def destroy
    @post.content.delete if @post.content.is_track? || @post.content.is_playlist
    @post.delete
    flash[:success] = t ".flash.success"
    redirect_to home_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    if @post.nil?
      redirect_to home_path
    end
  end

  def track_params
    params.require(:track).permit :name, :url
  end

  def create_track_post
    @track = current_user.tracks.build track_params
    if @track.save
      @post = current_user.posts.create content: @track
      redirect_to post_path(@post)
    else
      flash[:danger] = t ".flash.danger"
      redirect_to new_post_path(type: "track")
    end
  end

  def create_post
  end

  def create_playlist_post
  end
end
