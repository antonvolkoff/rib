require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rib
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"

    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
    end
  end
end
