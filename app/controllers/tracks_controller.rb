class TracksController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :find_user, only: [:show]

  def new
    @track = current_user.tracks.build
  end

  def create
    @track = current_user.tracks.build track_params
    if @track.save
      flash[:success] = t ".flash.success"
      @post = current_user.posts.create content: @track
      redirect_to post_path(@post)
    else
      flash[:danger] = t ".flash.danger"
      render "new"
    end
  end

  def show
    @track = @user.tracks.find_by id: params[:id]
  end

  private

  def track_params
    params.require(:track).permit(:name, :url, :is_private)
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    if @user.nil?
      flash[:danger] = "asdfj"
      redirect_to home_path
    end
  end
end
