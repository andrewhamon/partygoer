class SessionsController < ApplicationController
  def spotify_preauth
    user = User.find_by!(token: params[:token])
    session[:user_id] = user.id
    redirect_to "/auth/spotify"
  end

  def spotify_callback
    user = User.find(session[:user_id])
    rspotify_user = RSpotify::User.new(request.env["omniauth.auth"])
    spotify_user = SpotifyUser.find_or_initialize_by(sid: rspotify_user.id)

    spotify_user.token = rspotify_user.credentials.token
    spotify_user.token_expires_at = Time.at(rspotify_user.credentials.expires_at).to_datetime
    spotify_user.refresh_token = rspotify_user.credentials.refresh_token

    spotify_user.save!

    user.spotify_user = spotify_user
    user.save!

    redirect_to session[:redirect_url] || "/"
  end
end
