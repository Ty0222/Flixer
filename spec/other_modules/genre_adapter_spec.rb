require "rails_helper"

RSpec.describe GenreAdapter do
  
  it "responds to .all_genres" do
    expect(described_class.respond_to?(:all_genres)).to eq(true)
  end

  describe ".all_genres" do
    
    it "returns a list of genre data" do
      genre_list_data = double
      expect(GenreAdapter).to receive_message_chain(:get, :[]).and_return(genre_list_data)

      expect(GenreAdapter.all_genres).to eq(genre_list_data)
    end

    context "when the response from an external request yields no data" do  
      it "returns an empty collection" do
        no_genre_list_data = nil
        expect(GenreAdapter).to receive_message_chain(:get, :[]).and_return(no_genre_list_data)

        expect(GenreAdapter.all_genres).to eq([])
      end
    end
  end

end