require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Partygoer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_job.queue_adapter = :async

    # Add some arbitrarily large thread pool size so that changing songs (hopefully) never has to wait
    config.active_job.queue_adapter =
      ActiveJob::QueueAdapters::AsyncAdapter.new(
        min_threads: 1,
        max_threads: 30,
        idletime: 600.seconds,
      )
  end
end
