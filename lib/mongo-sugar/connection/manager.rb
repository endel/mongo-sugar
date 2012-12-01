require 'singleton'

module Mongo
  module Sugar
    module Connection

      #
      # Manages multiple database connections
      #
      class Manager
        include Singleton
        attr_reader :connections

        def initialize
          @connections = {}
        end

        # Create MongoDB connection
        #
        # @param [String] connection name
        # @param [String] connection URI (optional. default: ENV['MONGODB_URI'])
        #
        # @return [Mongo::Sugar::Connection] connection instance
        def self.create(name, uri=nil)
          self.instance.connections[name] = Connection.new(Config.instance.get(name) || ENV['MONGODB_URI'])
        end

        # Get MongoDB connection
        #
        # @param [String] connection name
        #
        # @return [Mongo::Connection, nil] connection or nil, if connection doesn't have been created
        def self.get(name)
          self.instance.connections[name] or self.create(name)
        end

        # Get database instance
        #
        # @param [String] connection name
        # @param [String] database to connect. (optional, inherit from your database URI, if specified)
        #
        # return [Mongo::DB] database instance
        def self.database(name, database=nil)
          self.get(name).database(database)
        end
      end

    end
  end
end
