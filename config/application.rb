require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Partygoer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.spotify_client_id = ENV.fetch("SPOTIFY_CLIENT_ID")
    config.spotify_client_secret = ENV.fetch("SPOTIFY_CLIENT_SECRET")

    RSpotify::authenticate(config.spotify_client_id, config.spotify_client_secret)

    config.active_job.queue_adapter = :async

    # Add some arbitrarily large thread pool size so that changeing songs (hopefully) never has to wait
    config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new min_threads: 1,
                                                                                 max_threads: 30,
                                                                                 idletime: 600.seconds

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: %i[head get post put delete options]
      end
    end
  end
end
