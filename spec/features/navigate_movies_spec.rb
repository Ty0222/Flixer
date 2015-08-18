
describe "Navigating Movies" do

  context "when user clicks 'All Movies' link" do
    it "allows navigation between detail page to listing page" do
    	movie = Movie.create(movie_attributes)	

      visit movie_url(movie)	
      click_on "All Movies"

      expect(current_path).to eq(root_path)
    end
  end

  context "when user clicks a movie's title (link)" do
    it "allows navigation between listing page to detail page" do
      movie = Movie.create(movie_attributes)

      visit movies_url
      click_on movie.title

      expect(current_path).to eq(movie_path(movie))
    end
  end

  context "when user clicks 'continue' link in description" do
    it "allows navigation between listing page to detail page" do
    	movie = Movie.create(movie_attributes)

    	visit movies_url
    	click_on "continue"

    	expect(current_path).to eq(movie_path(movie))
    end
  end
end