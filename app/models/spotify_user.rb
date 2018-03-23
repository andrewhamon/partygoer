# == Schema Information
#
# Table name: spotify_users
#
#  id               :integer          not null, primary key
#  sid              :string           not null
#  device_id        :string
#  token            :string           not null
#  token_expires_at :string           not null
#  refresh_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class SpotifyUser < ApplicationRecord
  validates :sid, uniqueness: true

  validates :token, :token_expires_at, :refresh_token, presence: true

  def list_devices
    api_request(:get, "/me/player/devices").fetch("devices")
  end

  def select_device(device_id)
    api_request(:put, "/me/player", device_ids: [device_id])
    self.device_id = device_id
    save!
  end

  def playback_state
    PlaybackState.from_spotify_hash(api_request(:get, "/me/player"))
  end

  def play(track = nil)
    payload = if track
                { uris: [track.uri] }
              end

    api_request(:put, "/me/player/play", payload)
  end

  def pause
    api_request(:put, "/me/player/pause")
  end

  def request_new_token!
    uri = URI("https://accounts.spotify.com/api/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    body = URI.encode_www_form(
      refresh_token: refresh_token,
      grant_type: "refresh_token",
    )

    req = Net::HTTP::Post.new(uri)
    req.basic_auth Rails.configuration.spotify_client_id, Rails.configuration.spotify_client_secret
    req.add_field "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"
    req.body = body

    res = http.request(req)
    result = JSON.parse(res.body)

    self.token = result.fetch("access_token")
    self.token_expires_at = result.fetch("expires_in").to_i.seconds.from_now
    save!
  end

  private

  def api_request(method, path, payload = nil)
    with_valid_token do
      req = "Net::HTTP::#{method.to_s.camelcase}".constantize.new(uri_for(path))
      req.add_field "Authorization", "Bearer #{token}"
      req.body = JSON.dump(payload) if payload

      res = http_client.request(req)

      JSON.parse(res.body) if res.body.present?
    end
  end

  def with_valid_token
    if token_expires_at < 10.minutes.from_now
      request_new_token!
    end
    yield
  end

  def http_client
    @http_client ||= create_http_client
  end

  def create_http_client
    uri = URI(base_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http
  end

  def base_url
    "https://api.spotify.com/v1/"
  end

  def uri_for(path)
    URI(File.join(base_url, path))
  end
end
