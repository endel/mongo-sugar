require 'mongo'

module Mongo
  module Sugar
    module Connection
      autoload :Config,  'mongo-sugar/connection/config'
      autoload :Manager, 'mongo-sugar/connection/manager'

      class Connection
        attr_reader :conn, :default_db

        def initialize(uri)
          raise "Connection#initialize: you must create a config/mongodb.yml file, or set ENV['MONGODB_URI']." if uri.nil?
          @conn = Mongo::Connection.from_uri(uri)

          # If URI doens't contain database part, get default connection's database name
          default_db = File.basename(uri)
          @default_db = default_db.index(':') ? @conn.db.name : default_db
        end

        # Get database reference from connection
        #
        # @param [String] database name
        #
        # @return [Mongo::DB] datbase reference
        def database(name=nil)
          @conn.db(name || @default_db)
        end
      end

    end
  end
end
