require "rails_helper"

RSpec.describe MovieAdapter do

  it "responds to .filter_by" do
    expect(described_class.respond_to?(:filter_by)).to eq(true)
  end

  it "responds to .filter_metadata_by" do
    expect(described_class.respond_to?(:filter_metadata_by)).to eq(true)
  end

  it "responds to .get_movie" do
    expect(described_class.respond_to?(:get_movie)).to eq(true)
  end

  describe ".filter_by" do
    
    it "returns a list of movie data based on a set of queries" do
      filtered_movie_list = double("filtered_list")

      allow(MovieAdapter).to receive_message_chain(:get, :[]).and_return(filtered_movie_list)

      expect(MovieAdapter.filter_by).to eq(filtered_movie_list)
    end

    context "when the response from an external request yields no data" do  
      it "returns an empty collection" do
        allow(MovieAdapter).to receive_message_chain(:get, :[]).and_return(nil)

        expect(MovieAdapter.filter_by).to eq([])
      end
    end
  end

  describe ".filter_metadata_by" do
    
    it "returns a hash with metadata about a specific list of movies based on a set of queries" do
      filtered_movie_list_metadata = double("filtered_movie_list_metadata")

      allow(MovieAdapter).to receive_message_chain(:get, :reject).and_return(filtered_movie_list_metadata)

      expect(MovieAdapter.filter_metadata_by).to eq(filtered_movie_list_metadata)
    end

    context "when the responds from and external request yields no data" do  
      it "returns an empty hash" do
        allow(MovieAdapter).to receive_message_chain(:get, :reject).and_return(nil)

        expect(MovieAdapter.filter_metadata_by).to eq({})
      end
    end
  end

  describe ".get_movie" do
    
    it "returns a hash with movie data" do
      expected_movie_data = double("movie_data")

      allow(MovieAdapter).to receive(:get).and_return(expected_movie_data)

      expect(MovieAdapter.get_movie(id: 2)).to eq(expected_movie_data)
    end

    context "when the response from an external request yields no data" do  
      it "returns an empty hash" do
        allow(MovieAdapter).to receive(:get).and_return(nil)

        expect(MovieAdapter.get_movie(id: 2)).to eq({})
      end
    end
  end

end