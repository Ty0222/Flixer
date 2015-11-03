
describe "Navigating Movies" do
  	
  context "when clicking All Movies link" do
    it "navigates between detail and listing page" do
    movie = Movie.create(movie_attributes)	

    visit movie_url(movie)	
    click_link "All Movies"

    expect(current_path).to eq(movies_path)
    end
  end

  context "when clicking a movie's title link" do
    it "navigates between detail and listing page" do
    movie = Movie.create(movie_attributes)

    visit movies_url
    click_on movie.title

    expect(current_path).to eq(movie_path(movie))
    end
  end

  context "when clicking 'continue' link" do
    it "allows navigation between listing and detail " do
    	movie = Movie.create(movie_attributes)

    	visit movies_url
    	click_on "continue"

    	expect(current_path).to eq(movie_path(movie))
    end
  end
end