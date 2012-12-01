require 'yaml'

module Mongo
  module Sugar
    module Connection

      #
      # Config file reader
      #
      class Config
        include Singleton

        def initialize(config=ENV['MONGODB_CONFIG'], environment=ENV['RACK_ENV'])
          config ||= 'config/mongo.yml'
          @config = (File.exists?(config)) ? YAML.load_file(config)[environment] : {}
        end

        # Retrieve a configuration key
        # @param [String] key
        # @return [String] database uri
        def get(name)
          @config[name]
        end

      end
    end
  end
end

