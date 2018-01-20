require File.expand_path('../boot', __FILE__)
require File.expand_path('../../lib/utility/utility', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flixer
  class Application < Rails::Application

    custom_paths = ["lib", "lib/data_access"]

    # # Adds custom paths to autoload paths
    Utility.merge_lists_of_paths(path_list: config.autoload_paths, paths_to_add: custom_paths)

    SourceAnnotationExtractor.enumerate("TODO", dirs: %w(spec), tag: true) # directories: app, config, db, lib, test, spec
        
    console do
      ActiveRecord::Base.connection
    end

    config.generators do |g|
    	g.test_framework false
    end
  end
end