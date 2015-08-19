
describe "Viewing an individual movie" do
  it "shows the movie details" do

  	movie = Movie.create(movie_attributes)
  
  	visit movie_url(movie)

  	expect(page).to have_content(movie.title)
  	expect(page).to have_content(movie.rating)
  	expect(page).to have_content(movie.description)
  	expect(page).to have_content("May 7th, 2010")
    expect(page).to have_content(movie.cast)
    expect(page).to have_content(movie.director)
    expect(page).to have_content(movie.duration)
    expect(page).to have_selector("img[src$='#{movie.image_file_name}']")
  end

  it "shows the total gross if total gross exceeds 50M" do
  	movie = Movie.create(movie_attributes(total_gross: 623933331.00))

  	visit movie_url(movie)

  	expect(page).to have_content("$623,933,331.00")
  end

  it "shows 'Flop' if total gross is less than 50M" do
  	movie = Movie.create(movie_attributes(total_gross: 23933331.00))	
  
  	visit movie_url(movie)

  	expect(page).to have_content("Flop!")
  end
end