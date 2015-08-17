
describe "Navigating movies" do
  it "allows navigation between detail page to listing page" do
  	movie = Movie.create(movie_attributes)	
	
	visit movie_url(movie)	
	click_on "All Movies"

	expect(current_path).to eq(root_path)
  end

  context "when clicking movie title" do
    it "allows navigation between listing page to detail page" do
      movie = Movie.create(movie_attributes)

      visit movies_url
      click_on movie.title

      expect(current_path).to eq(movie_path(movie))
    end
  end

  context "when clicking 'continue' link in description" do
    it "allows navigation between listing page to detail page" do
    	movie = Movie.create(movie_attributes)

    	visit movies_url
    	click_on "continue"

    	expect(current_path).to eq(movie_path(movie))
    end
  end
end