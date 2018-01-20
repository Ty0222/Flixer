require "rails_helper"

RSpec.feature "Listing movies" do
	
  it "displays a collection of movies" do
    movie1 = movie_list_data
    movie2 = movie_list_data(title: "Batman")
    Movie.movie_list_source = ->(page) {[movie1, movie2]}
    Movie.movie_list_metadata_source = ->(page) {movie_list_metadata(page: 2)}
  	
    visit movies_url(page: 2)

    expect(page).to have_content("Iron Man 2")
    expect(page).to have_content("Batman")
  	expect(page).to have_selector("img[src$='rating_icon.png']")
  	expect(page).to have_content("May 7th, 2010")
    expect(page).to have_selector("img[src$='iron_man2.jpg']")
  end

  context "when there are no movies to display" do  
    it "dispays the words 'Sorry no matches'" do
      Movie.movie_list_source = ->(page) {[]}

      visit movies_url(page: 1)

      expect(page).to have_content("Sorry no matches")
    end
  end

  context "when selecting 'Hits Only' within the navigation menu" do  
    it "displays only a collection of movies that are considered a hit" do
      Movie.movie_list_source = ->(page) {[movie_list_data]}
      Movie.movie_list_metadata_source = ->(page) {movie_list_metadata}

      visit movies_url(page: 1)

      movie2 = movie_list_data(vote_count: 100, vote_average: 8)
      movie2_metadata = movie_list_metadata
      Movie.movie_list_source = ->(page) {[movie2]}
      Movie.movie_list_metadata_source = ->(page) {movie2_metadata}

      click_link "Hits Only"
      
      expect(page).to have_content("HIT")
    end
  end

end