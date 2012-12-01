Mongo Sugar [![Build Status](https://secure.travis-ci.org/endel/mongo-sugar.png)](http://travis-ci.org/endel/mongo-sugar)
===

Provide a syntatic sugar for MongoDB ruby driver, similar to an ORM.

But it isn't another ORM. If you need relationship features, you should use
[MongoID](http://mongoid.org/), [MongoMapper](http://mongomapper.com/), or, why
not - a relational database.

Usage
===

Add mongo-sugar to your gemfile:

    gem 'mongo-sugar'

Require it on your code:

    require 'mongo-sugar'

Define classes as collections. By default, collection names are the class name
underscored. On the following example, the collection name is `my_collection`.

    class MyCollection < Mongo::Sugar::Collection
      #
      # Define your custom methods, like this:
      #
      def do_upsert(hash)
        @collection.update({
          key: hash[:key]
        }, {
          :$addToSet => {
            :value => hash[:value]
          }
        }, :upsert => true)
      end
    end

You can customize the collection names using `store_in`, which is similar to mongoid
syntax.

    class MyCollection < Mongo::Sugar::Collection
      store_in :collection => 'custom_collection'
    end

For more details, read the [documentation](http://endel.github.com/mongo-sugar) here.

License
===

This library is released under MIT License. Please see LICENSE file.
