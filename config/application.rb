require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Mcut2018Garage
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = 'Asia/Taipei'
    config.i18n.default_locale = "zh-TW"
    config.generators do |g|
      g.test_framework :rspec, fixture_replacement: :fabrication
      g.fixture_replacement :fabrication, dir: "spec/fabricators"
    end
  end
end
