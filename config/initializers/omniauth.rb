require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  scopes = "user-read-playback-state user-modify-playback-state user-read-currently-playing user-read-recently-played"
  provider :spotify, ENV.fetch("SPOTIFY_CLIENT_ID"), ENV.fetch("SPOTIFY_CLIENT_SECRET"), scope: scopes
end
