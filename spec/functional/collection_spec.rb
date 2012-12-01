require 'spec_helper'

describe Mongo::Sugar::Collection do
  subject { Mongo::Sugar::Collection }

  before(:all) do
    ENV['MONGODB_URI'] = 'mongodb://localhost:27017/mongo_sugar_test'
    ENV['MONGODB_CONFIG'] = 'spec/fixtures/config.yml'
  end

  context "defining collections" do

    it "without #store_in call" do
      class DummyCollection < subject; end
      DummyCollection.collection.name.should == 'dummy_collection'
      DummyCollection.database.name.should == 'mongo_sugar_test'
    end

    it "change database and collection with #store_in call" do
      class CustomCollection < subject
        store_in :collection => 'custom'
      end
      CustomCollection.collection.name.should == 'custom'
      CustomCollection.database.name.should == 'mongo_sugar_test'

      class CustomDatabaseCollection < subject
        store_in :collection => 'custom', :database => 'mongo_sugar_two'
      end
      CustomDatabaseCollection.collection.name.should == 'custom'
      CustomDatabaseCollection.database.name.should == 'mongo_sugar_two'
    end

    it "has @collection visible for custom methods" do
      class IHateFooExamples < subject
        store_in :collection => 'bazinga_bar'
        def respond_to_find?
          @collection.respond_to?(:find)
        end
      end
      IHateFooExamples.collection.name.should == 'bazinga_bar'
      IHateFooExamples.collection.respond_to_find?.should == true
    end

    it "specifying another connection" do
      class AnotherConnection < subject
        store_in :collection => "another", :connection => 'second'
      end
      AnotherConnection.collection.name.should == 'another'
      AnotherConnection.database.name.should == 'mongo_sugar_test_2'
    end
  end

end
