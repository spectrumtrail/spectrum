require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Spectrum
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.active_job.queue_adapter = :sidekiq

    config.generators do |generator|
      generator.helper false
      generator.assets false
      generator.view_specs false
      generator.test_framework  false
      generator.factory_bot suffix: "factory"
    end

    config.middleware.use(Rack::Tracker) do
      handler :google_analytics, { tracker: ENV['GOOGLE_ANALYTICS_ID'], ecommerce: true, position: :body }
      handler :facebook_pixel, { id: ENV['PIXEL_ID'], position: :body }
    end

    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
