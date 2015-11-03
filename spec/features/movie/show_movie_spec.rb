#app/views/movies/show.html.erb

describe "Viewing an individual movie" do
  
  it "shows a movie's details" do
    movie = Movie.create(movie_attributes)
  
  	visit movie_url(movie)

  	expect(page).to have_content(movie.title)
  	expect(page).to have_content(movie.rating)
  	expect(page).to have_content(movie.description)
  	expect(page).to have_content("May 7th, 2010")
    expect(page).to have_content(movie.cast)
    expect(page).to have_content(movie.director)
    expect(page).to have_content(movie.duration)
    expect(page).to have_selector("img[src$='#{movie.image.url(:default)}']")
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

  it "shows 'No reviews' when none exist for a movie" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_content("No reviews")
    expect(page).to_not have_content("**")
    expect(page).to_not have_content("0 stars")
  end

  it "shows average number of stars for a movie" do
    movie = Movie.create(movie_attributes)
    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))

    visit movie_url(movie)

    expect(page).to have_content("**")
    expect(page).to_not have_content("No reviews")
  end
end