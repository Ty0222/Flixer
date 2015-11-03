describe "Editing A Movie" do

	it "updates the movie and shows a movie's updated details with message of success" do
	  movie = Movie.create(movie_attributes)

	  visit movie_url(movie)
	  click_link "Edit"

	  expect(current_path).to eq(edit_movie_path(movie))
	  expect(find_field("Title").value).to eq(movie.title)
	  expect(find_field("Description").value).to eq(movie.description)
	  expect(find_field("Worldwide Gross").value).to eq(movie.total_gross.to_i.to_s)

		select "PG", from: "movie_rating"
		click_on "Update Movie"

		expect(current_path).to eq(movie_path(movie))
		expect(page).to have_content("PG")
    expect(page).to have_content("Movie successfully updated!")
	end  

  it "does not update movie and returns error message(s) when invalid" do
    movie = Movie.create(movie_attributes)

    visit edit_movie_url(movie)
    fill_in "Title", with: ""
    click_on "Update Movie"

    expect(page).to have_content("Title can't be blank")
  end
end