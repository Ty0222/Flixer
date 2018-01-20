require_relative "interfaces/data_access_builder_interface"
require "rails_helper"

RSpec.describe Movie do

  it "responds to .now_playing" do
    expect(described_class.respond_to?(:now_playing)).to eq(true)
  end

  it "responds to .now_playing_by_genre" do
    expect(described_class.respond_to?(:now_playing_by_genre)).to eq(true)
  end

  it "responds to .get_movie" do
    expect(described_class.respond_to?(:get_movie)).to eq(true)
  end

  it "responds to .movie_list_metadata" do
    expect(described_class.respond_to?(:movie_list_metadata)).to eq(true)
  end

  describe ".now_playing" do

    it "returns a collection of movie objects" do
      movie_list_collection = [{id: 1}, {id: 2}]
      Movie.movie_list_source = ->(page) {movie_list_collection}
      
      result = Movie.now_playing

      expect(result).to be_a(Array)
      expect(result.first).to be_a(Movie)
      expect(result.first).to have_attributes(id: 1)
      expect(result.last).to have_attributes(id: 2)
    end
# TODO: copy spec below to other applicable methods
    context "when its 'hit_status' parameter is set to true" do  
      it "only returns a collection of movie objects with total votes above 100 and an above 7 vote rating" do
        movie_list_collection = [{id: 1, vote_average: 7, vote_count: 100}]
        Movie.movie_list_source = ->(page) {movie_list_collection}
        
        result = Movie.now_playing(hit_status: true)

        expect(result).to be_a(Array)
        expect(result.first).to be_a(Movie)
        expect(result.first).to have_attributes(id: 1)
      end
    end
  end

  describe ".now_playing_by_genre" do

    it "returns a collection of movie objects based on a given genre" do
      filtered_movie_list_collection = [ {id: 1, genre_ids: [8, 11]}, {id: 2, genre_ids: [13, 44]} ]
      Movie.filtered_movie_list_source = ->(with_genres) {filtered_movie_list_collection}
      
      result = Movie.now_playing_by_genre(with_genres: [8, 13])

      expect(result).to be_a(Array)
      expect(result.first).to be_a(Movie)
      expect(result.first).to have_attributes(id: 1)
      expect(result.last).to have_attributes(id: 2)
      expect(result.last.genre_ids).to contain_exactly(13, 44)
    end
  end

  describe ".get_movie" do

    it "returns a movie obect" do
      Movie.movie_fetcher = ->(id) { movie_data(id: 2) }
      
      result = Movie.get_movie(id: 2)
      
      expect(result).to be_a(Movie)
      expect(result).to have_attributes(id: 2)
    end
  end

  describe ".movie_list_metadata" do

    it "returns an object containing metadata about list of movies" do
      movie_metadata = {page: 1, total_pages: 10}
      Movie.movie_list_metadata_source = ->(page) {movie_metadata}

      result = Movie.movie_list_metadata

      expect(result.page).to eq(1)
      expect(result.total_pages).to eq(10)
    end
  end

  it "responds to #id" do
    expect(described_class.new.respond_to?(:id)).to eq(true)
  end

  it "responds to #title" do
    expect(described_class.new.respond_to?(:title)).to eq(true)
  end

  it "responds to #image" do
    expect(described_class.new.respond_to?(:image)).to eq(true)
  end

  it "responds to #released_on" do
    expect(described_class.new.respond_to?(:released_on)).to eq(true)
  end

  it "responds to #vote_rating" do
    expect(described_class.new.respond_to?(:vote_rating)).to eq(true)
  end

  it "responds to #total_votes" do
    expect(described_class.new.respond_to?(:total_votes)).to eq(true)
  end

  it "responds to #overview" do
    expect(described_class.new.respond_to?(:overview)).to eq(true)
  end

  it "responds to #revenue" do
    expect(described_class.new.respond_to?(:revenue)).to eq(true)
  end

  it "responds to #duration" do
    expect(described_class.new.respond_to?(:duration)).to eq(true)
  end

  it "responds to #background_poster" do
    expect(described_class.new.respond_to?(:background_poster)).to eq(true)
  end

  it "responds to #genres" do
    expect(described_class.new.respond_to?(:genres)).to eq(true)
  end

  it "responds to #hit_movie?" do
    expect(described_class.new.respond_to?(:hit_movie?)).to eq(true)
  end

  describe "#vote_rating" do
    
    it "rounds a given vote rating" do
      movie = Movie.new(vote_rating: 7.3)

      expect(movie.vote_rating).to eq(7)
    end
  end

  describe "#hit_movie?" do
    
    context "when a movie's vote rating is at least a 7 and its total votes have reached 100" do  
      it "returns true" do
        movie = Movie.new(vote_rating: 7, total_votes: 100)

        expect(movie.hit_movie?).to eq(true)
      end
    end

    context "when a movie's vote rating is below a 7" do  
      it "returns false" do
        movie = Movie.new(vote_rating: 6, total_votes: 100)

        expect(movie.hit_movie?).to eq(false)
      end
    end

    context "when a movie's total votes have not reached 100" do  
      it "returns false" do
        movie = Movie.new(vote_rating: 7, total_votes: 99)

        expect(movie.hit_movie?).to eq(false)
      end
    end
  end

end