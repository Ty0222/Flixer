describe "Editing A Movie" do

  context "when user clicks 'Edit' link" do
  	it "shows edit form with movie's current details" do
  	  movie = Movie.create(movie_attributes)

  	  visit movie_url(movie)
  	  click_link "Edit"

  	  expect(current_path).to eq(edit_movie_path(movie))
  	  expect(find_field("Title").value).to eq(movie.title)
  	  expect(find_field("Rating").value).to eq(movie.rating)
  	  expect(find_field("Description").value).to eq(movie.description)
  	  expect(find_field("Worldwide Gross").value).to eq(movie.total_gross.to_i.to_s)
  	end
  end	

  context "when user fills out form and clicks 'Update'" do
  	it "redirects to movie page with updated movie details" do
  		movie = Movie.create(movie_attributes)

  		visit movie_url(movie)
  		click_link "Edit"
  		fill_in "Rating", with: "PG"
  		click_button "Update Movie"

  		expect(current_path).to eq(movie_path(movie))
  		expect(page).to have_content("PG")
  	end
  end
end