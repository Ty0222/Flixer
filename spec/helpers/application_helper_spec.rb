require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  
  describe "#get_movies_url" do

    context "when there is movie list metadata" do  
      it "returns metadata's url to a listing of movies" do
        movie_list_metadata = double(page: 1)
        allow(movie_list_metadata).to receive_message_chain(:movie_list_url).with(anything).and_return("METADATA_URL")
        result = helper.get_movies_url(movie_list_metadata)
        
        expect(result).to eq("METADATA_URL")
      end
    end
    
    context "when there is no movie list metadata" do  
      it "returns a default url to a listing of movies" do
        empty_movie_list_metadata = nil
        result = helper.get_movies_url(empty_movie_list_metadata)
        
        expect(result).to eq(movies_url(hit_status: false))
      end
    end
  end

  describe "#get_hit_movies_url" do

    context "when there is movie list metadata" do  
      it "returns metadata's url to a listing of hit movies" do
        movie_list_metadata = double(page: 1)
        allow(movie_list_metadata).to receive_message_chain(:movie_list_url).with(anything).and_return("METADATA_URL")
        result = helper.get_hit_movies_url(movie_list_metadata)
        
        expect(result).to eq("METADATA_URL")
      end
    end
    
    context "when there is no movie list metadata" do  
      it "returns a default url to a listing of hit movies" do
        empty_movie_list_metadata = nil
        result = helper.get_hit_movies_url(empty_movie_list_metadata)
        
        expect(result).to eq(movies_url(hit_status: true))
      end
    end
  end

end