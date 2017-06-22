class TracksController < ApplicationController
  load_and_authorize_resource

  def new
    @track = current_user.tracks.build
  end

  def create
    @track = current_user.tracks.build track_params
    if @track.save
      flash[:success] = t ".flash.success"
      redirect_to home_path
    else
      flash[:danger] = t ".flash.danger"
      redirect_to new_track_path
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def track_params
    params.require(:track).permit :name, :url, :is_private
  end
end
