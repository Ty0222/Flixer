
describe "Navigating Movies" do

  it "allows navigation between detail and listing page when user clicks 'All Movies' link" do
  	movie = Movie.create(movie_attributes)	

    visit movie_url(movie)	
    click_link "All Movies"

    expect(current_path).to eq(movies_path)
  end

  context "" do
    it "allows navigation between listing and detail page when user clicks movie's title" do
      movie = Movie.create(movie_attributes)

      visit movies_url
      click_on movie.title

      expect(current_path).to eq(movie_path(movie))
    end
  end

  context "" do
    it "allows navigation between listing and detail page when user clicks 'continue'" do
    	movie = Movie.create(movie_attributes)

    	visit movies_url
    	click_on "continue"

    	expect(current_path).to eq(movie_path(movie))
    end
  end
end