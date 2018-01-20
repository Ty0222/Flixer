require_relative "interfaces/data_access_builder_interface"
require "rails_helper"

RSpec.describe Genre do

  it "responds to .all" do
    expect(described_class.respond_to?(:all)).to eq(true)
  end

  describe ".all" do
    
    it "returns a collection of genre objects" do
      Genre.genre_list_source = -> {[genre_list_data]}
      result = Genre.all

      expect(result).to be_a(Array)
      expect(result.first).to be_a(Genre)
      expect(result.first).to have_attributes(id: 1)
      expect(result.first).to have_attributes(name: "Action")
    end
  end
  
  it "responds to #id" do
    expect(described_class.new.respond_to?(:id)).to eq(true)
  end

  it "responds to #name" do
    expect(described_class.new.respond_to?(:name)).to eq(true)
  end

end