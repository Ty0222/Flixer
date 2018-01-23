require_relative "movie_metadata/pagination"
require "rails_helper"

RSpec.describe MovieMetadataDecorator do

  include_examples "decorator interface"
  
  it "responds to #movie_list_url" do
    expect(described_class.new(double).respond_to?(:movie_list_url)).to eq(true)
  end

  describe "#movie_list_url" do
    
    it "returns the url to a list of movies" do
      context = TestContext.new
      decorator = MovieMetadataDecorator.decorate(double)

      expect(decorator.movie_list_url(page: 1, context: context)).to include("movies/catalog/page/1")
    end
  end

  include_examples "movie metadata pagination"

end