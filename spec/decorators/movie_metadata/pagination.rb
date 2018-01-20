RSpec.shared_examples "movie metadata pagination" do
  
  it "responds to #previous_page_link" do
    expect(described_class.new(double).respond_to?(:previous_page_link)).to eq(true)
  end

  it "responds to #next_page_link" do
    expect(described_class.new(double).respond_to?(:next_page_link)).to eq(true)
  end

    it "responds to #pagination_links" do
    expect(described_class.new(double).respond_to?(:next_page_link)).to eq(true)
  end

  describe "#previous_page_link" do
    
    it "returns an HTML link to the previous page of movie listings" do
      context = TestContext.new
      decorator = described_class.decorate(double(page: 2))
      
      expect(decorator.previous_page_link(context)).to include("Prev")
      expect(decorator.previous_page_link(context)).to include(decorator.movie_list_url(page: 1, context: context))
    end
  end

  describe "#next_page_link" do
    
    it "returns an HTML link to the next page of movie listings" do
      context = TestContext.new
      decorator = described_class.decorate(double(page: 1))
      
      expect(decorator.next_page_link(context)).to include("Next")
      expect(decorator.next_page_link(context)).to include(decorator.movie_list_url(page: 2, context: context))
    end
  end

  describe "#pagination_links" do
    
    it "returns a series of, no more than 10, numbered HTML page links of movie listings at a time" do
      context = TestContext.new
      decorator = described_class.new(double(page: 3, total_pages: 12))

      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 1, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 2, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 9, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 10, context: context))
      expect(decorator.pagination_links(context)).not_to include(decorator.movie_list_url(page: 11, context: context))
    end

    it "doesn't surpass total number of available pages" do
      context = TestContext.new
      decorator = described_class.new(double(page: 3, total_pages: 6))

      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 1, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 2, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 5, context: context))
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 6, context: context))
      expect(decorator.pagination_links(context)).not_to include(decorator.movie_list_url(page: 7, context: context))
    end

    it "disables link to the current page" do
      context = TestContext.new
      decorator = described_class.new(double(page: 1, total_pages: 2))

      expect(decorator.pagination_links(context)).not_to include(decorator.movie_list_url(page: 1, context: context))
      expect(decorator.pagination_links(context)).to include("1") # text for disabled link
      expect(decorator.pagination_links(context)).to include(decorator.movie_list_url(page: 2, context: context))
    end

  end

end