class PlaylistsController < ApplicationController
  load_and_authorize_resource through: :current_user
  load_and_authorize_resource :post, parent: true

  def index
    respond_to do |format|
      format.js
    end
  end

  def create
    @playlist.initial_track = @post.original_content
    @playlist.save
    respond_to do |format|
      format.js
    end
  end

  private

  def create_params
    params.require(:playlist).permit :name
  end
end
