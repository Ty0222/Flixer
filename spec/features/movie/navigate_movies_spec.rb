describe "Navigating Movies" do
  	
  it "navigates between detail and listing page via All Movies link" do
  movie = Movie.create(movie_attributes)	

  visit movie_url(movie)	
  click_link "All Movies"

  expect(current_path).to eq(movies_path)
  end

  it "navigates between detail and listing page via movie image" do
  movie = Movie.create(movie_attributes)

  visit movies_url
  find(".movie-container a:first-of-type").click

  expect(current_path).to eq(movie_path(movie))
  end

  it "allows navigation detail and listing page via info button" do
  	movie = Movie.create(movie_attributes)

  	visit movies_url
  	find(".movie-container a:first-of-type").click

  	expect(current_path).to eq(movie_path(movie))
  end
end