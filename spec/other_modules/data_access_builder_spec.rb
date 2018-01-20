require_relative "../models/interfaces/data_access_builder_interface"
require "rails_helper"

class ClassDouble
  include DataAccess::Builder
  attr_accessor :attribute1, :attribute2
end

RSpec.describe ClassDouble do
  include_examples "data access builder interface"
end

RSpec.describe DataAccess::Builder do

  context "when module gets included in a class" do 

    describe ".builds_object" do
        
      it "dynamically defines a builder method based on the value of its first paramter" do
        builder = ClassDouble
        param = "param_value"

        builder.builds_object(param)

        dynamically_defined_method = "build_#{param}_with"

        expect(builder.respond_to?(dynamically_defined_method)).to eq(true)
      end

    end

    describe ".build_[.build_object's first parameter]_with" do

      let(:builder) { ClassDouble }

      context "when it receives a collection of hashes containing data" do  
        it "creates an object from the current class for every hash it maps the object's attributes to the given hash's data" do
          collection = [{"data_key1" => "bar"}, {data_key2: 1}]

          builder.builds_object :new_collection, mappings: {attribute1: "data_key1", attribute2: "data_key2"}
          
          new_collection = builder.build_new_collection_with(collection)

          expect(new_collection.first.attribute1).to eq("bar")
          expect(new_collection.last.attribute2).to eq(1)
        end
      end

      context "when it receives an empty collection" do  
        it "returns an empty collection" do
          builder.builds_object :new_collection, mappings: {attribute1: "data_key1"}

          new_object = builder.build_new_collection_with([])

          expect(new_object).to eq([])
        end
      end

      context "when it receives a hash containing data" do  
        it "creates an object from the current class it maps the object's attributes to the given hash's data" do
          has_data = {data_key1: "bar"}

          builder.builds_object :new_object, mappings: {attribute1: "data_key1"}
          
          new_object = builder.build_new_object_with(has_data)

          expect(new_object.attribute1).to eq("bar")
        end
      end

      context "when it receives an empty hash" do  
        it "returns nil" do
          builder.builds_object :new_object, mappings: {attribute1: "data_key1"}

          new_object = builder.build_new_object_with({})

          expect(new_object).to eq(nil)
        end
      end

      context "when mapping a new object's attributes to the data within a hash" do

        context "when a key within the given hash is pointing to a collection" do  
          it "sets the collection as the value for the new object's mapped attribute" do
            data_collection = { data_key1: [3, "hello world"] }
            
            builder.builds_object :new_object, mappings: {attribute1: "data_key1"}

            new_object = builder.build_new_object_with(data_collection)

            expect(new_object.attribute1).to be_a(Array)
            expect(new_object.attribute1.first).to eq(3)
            expect(new_object.attribute1.last).to eq("hello world")
          end
        end

        context "when a key within the given hash is pointing to a collection of data-filled hashes" do  
          it "converts each hash index into an object and uses its data for the object's attribute name and value, then returns each in a collection" do
            hash_data = { data_key1: [{collection_data_key1: "bar1", collection_data_key2: "bar2"}, {collection_data_key1: "foo"}] }

            builder.builds_object :new_object, mappings: {attribute1: "data_key1"}

            new_object = builder.build_new_object_with(hash_data)

            expect(new_object.attribute1).to be_a(Array)
            expect(new_object.attribute1.first.collection_data_key1).to eq("bar1")
            expect(new_object.attribute1.last.collection_data_key1).to eq("foo")
          end
        end

        context "when a key within the given hash is pointing to an empty collection" do  
          it "returns an empty collection" do
            hash_data = { data_key1: [] }

            builder.builds_object :new_object, mappings: {attribute1: "data_key1"}

            new_object = builder.build_new_object_with(hash_data)

            expect(new_object.attribute1).to eq([])
          end
        end
      end

    end
  end

end