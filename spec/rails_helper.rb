require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!

  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.javascript_driver = :selenium_chrome

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = false

    config.infer_spec_type_from_file_location!

    config.filter_rails_from_backtrace!

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, js: true) do
      DatabaseCleaner.strategy = :truncation
    end

    # This block must be here, do not combine with the other `before(:each)` block.
    # This makes it so Capybara can see the database.
    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end
