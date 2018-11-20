ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|

  config.use_transactional_fixtures = true

  #     RSpec.describe UsersController, :type => :controller do
  #     end
  config.infer_spec_type_from_file_location!
  config.before(:suite) do DatabaseCleaner.clean_with(:truncation) end
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
end
