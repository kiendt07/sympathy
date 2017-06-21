module PlaylistHelper
  def render_playlists_links post, playlists
    playlists_links = playlists.map do |playlist|
      link = link_to playlist.name,
        playlistings_path(
          playlisting: {
            track_id: post.original_content.id,
            playlist_id: playlist.id
          },
          format: :js
        ), class: "playlist-link", method: :post, remote: true
      "<li>#{link}</li>"
    end
    playlists_links.join
  end
end
