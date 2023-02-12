# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require_relative './auth_helper'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.include RSpec::JsonExpectations::Matchers

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

rb_version = Gem::Version.new(RUBY_VERSION)

if rb_version >= Gem::Version.new('2.6') && Gem::Version.new(Rails.version) < Gem::Version.new('5')
  if ! defined?(::ActionController::TestResponse)
    raise "Needed class is not defined yet, try requiring this file later."
  end

  if rb_version >= Gem::Version.new('2.7')
    puts "Using #{__FILE__} for Ruby 2.7."

    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        @mon_data = nil
        @mon_data_owner_object_id = nil
        initialize
      end
    end

    class ActionController::LiveTestResponse < ActionController::Live::Response
      def recycle!
        @body = nil
        @mon_data = nil
        @mon_data_owner_object_id = nil
        initialize
      end
    end

  else
    puts "Using #{__FILE__} for Ruby 2.6."

    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        @mon_mutex = nil
        @mon_mutex_owner_object_id = nil
        initialize
      end
    end

    class ActionController::LiveTestResponse < ActionController::Live::Response
      def recycle!
        @body = nil
        @mon_mutex = nil
        @mon_mutex_owner_object_id = nil
        initialize
      end
    end

  end
else
  puts "#{__FILE__} no longer needed."
end