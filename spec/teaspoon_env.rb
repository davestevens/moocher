unless defined?(Rails)
  ENV["RAILS_ROOT"] = File.expand_path("../../", __FILE__)
  require File.expand_path("../../config/environment", __FILE__)
end

Teaspoon.configure do |config|
  config.asset_paths = ["spec/javascripts"]
  config.fixture_paths = ["spec/javascripts/fixtures"]
  config.suite do |suite|
    suite.use_framework :mocha
    suite.matcher = "{spec/javascripts}/**/*_spec.{js,js.coffee,coffee}"
    suite.helper = "spec_helper"
    suite.boot_partial = "boot_require_js"
  end
end
