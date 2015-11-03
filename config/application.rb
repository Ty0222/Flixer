require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flix
  class Application < Rails::Application
        
    console do
      ActiveRecord::Base.connection
    end

    config.generators do |g|
    	g.test_framework false
    end
  end
end