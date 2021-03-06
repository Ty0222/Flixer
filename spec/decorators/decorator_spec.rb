require_relative "interfaces/decorator_interface"
require_relative "../../app/decorators/decorator"

RSpec.describe Decorator do

  include_examples "decorator interface"

  it "delegates all unknown messages to its underlying class" do
    decorator = Decorator.decorate(double(foo: "bar"))

    expect(decorator.foo).to eq("bar")
  end
  
  describe "#to_model" do
    it "returns the underlying object" do
      object = double
      decorated_object = Decorator.decorate(object)

      expect(decorated_object.to_model).to eq(object)
    end
  end

  describe "#class" do
    it "returns the class of the underlying object" do
      object = double
      decorated_object = Decorator.decorate(object)

      expect(decorated_object.class).to eq(object.class)
    end
  end

  describe ".decorate" do
    
    context "when its underlying object is a collection" do  
      it "returns a collection of objects each decorated by instances of the current class" do
        object1, object2 = double(decorated_object_method: "object1"), double
        collection = [object1, object2]

        decorated_collection = Decorator.decorate(collection)

        expect(decorated_collection).to contain_exactly(object1, object2)
        expect(decorated_collection.first).to be_a(Decorator)
        expect(decorated_collection.last).to be_a(Decorator)
        expect(decorated_collection.first.decorated_object_method).to eq("object1")
      end
    end

    context "when its underlying object is not a collection" do  
      it "returns a decorated object instance of the current class" do
        object = double(decorated_object_method: "object1")

        decorated_object = Decorator.decorate(object)

        expect(decorated_object).to be_a(Decorator)
        expect(decorated_object.decorated_object_method).to eq("object1")
      end
    end

    context "when its underlying object is nil" do  
      it "returns nil from NilClass" do
        decorated_object = Decorator.decorate(nil)
        
        expect(decorated_object).to eq(nil)
        expect(decorated_object).to be_a(NilClass)
      end
    end
  end

end