require_relative "movie_metadata/pagination"
require "rails_helper"

RSpec.describe MovieMetadataByGenreDecorator do

  include_examples "decorator interface"
  
  it "responds to #movie_list_url" do
    expect(described_class.new(double).respond_to?(:movie_list_url)).to eq(true)
  end

  describe "#movie_list_url" do
    
    it "returns the url to a list of movies" do
      test_context = ApplicationController.new
      test_context.request = ActionDispatch::TestRequest.new
      decorator = MovieMetadataByGenreDecorator.decorate(object: double)

      expect(decorator.movie_list_url(page: 1, context: test_context)).to include("movies/catalog/filters/genres/1/page/1")
    end
  end

  include_examples "movie metadata pagination"

end