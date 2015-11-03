describe "Navigating Movies" do
  	
  it "navigates between detail and listing page" do
  movie = Movie.create(movie_attributes)	

  visit movie_url(movie)	
  click_link "All Movies"

  expect(current_path).to eq(movies_path)
  end

  it "navigates between detail and listing page" do
  movie = Movie.create(movie_attributes)

  visit movies_url
  click_on movie.title

  expect(current_path).to eq(movie_path(movie))
  end

  it "allows navigation between listing and detail " do
  	movie = Movie.create(movie_attributes)

  	visit movies_url
  	click_on "continue"

  	expect(current_path).to eq(movie_path(movie))
  end
end