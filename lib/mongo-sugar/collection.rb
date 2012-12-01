require 'singleton'
require 'delegate'

module Mongo
  module Sugar
    class Collection < Delegator
      include Singleton
      attr_reader :database

      #
      # Class methods
      #

      class << self
        attr_reader :store_in_options
        alias :collection :instance

        def database
          self.instance.database
        end

        def store_in(options)
          @store_in_options = options
        end
      end

      #
      # Instance methods
      #

      def initialize(store_in={})
        __setobj__(self.class.store_in_options || {})
      end

      def __setobj__(store_in_options)
        conn = store_in_options.delete(:connection) || 'default'
        db = store_in_options.delete(:database)
        coll = store_in_options.delete(:collection) || self.class.name.delete(':').gsub(/(.)([A-Z])/,'\1_\2').downcase

        @database = Mongo::Sugar::Connection::Manager.database(conn, db)
        @collection = @database[coll]
      end

      def __getobj__
        @collection
      end

    end
  end
end
