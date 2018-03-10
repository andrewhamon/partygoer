Rails.application.config.spotify_client_id = ENV.fetch("SPOTIFY_CLIENT_ID")
Rails.application.config.spotify_client_secret = ENV.fetch("SPOTIFY_CLIENT_SECRET")

RSpotify::authenticate(
  Rails.application.config.spotify_client_id,
  Rails.application.config.spotify_client_secret,
)
