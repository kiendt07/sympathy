class PlaylistingsController < ApplicationController
  load_and_authorize_resource

  def create
    @playlisting.save
    respond_to do |format|
      format.js
    end
  end

  private

  def create_params
    params.require(:playlisting).permit :track_id, :playlist_id
  end
end
