describe "Editing A Movie" do

	context "when admin user" do

		before { @user = User.create(user_attributes) }

		it "updates the movie and shows a movie's updated details with message of success" do
		  movie = Movie.create(movie_attributes)

		  login(@user)
		  visit movie_url(movie)
		  click_link "Edit"

		  expect(current_path).to eq(edit_movie_path(movie))
		  expect(find_field("movie[title]").value).to eq(movie.title)
		  expect(find_field("movie[description]").value).to eq(movie.description)
		  expect(find_field("movie[total_gross]").value).to eq(movie.total_gross.to_i.to_s)

			select "PG", from: "movie_rating"
			click_on "Update Movie"

			expect(current_path).to eq(movie_path(movie))
			expect(page).to have_content("PG")
	    expect(page).to have_content("Movie successfully updated!")
		end  

	  it "does not update movie and returns error message(s) when invalid" do
	    movie = Movie.create(movie_attributes)

	    login(@user)
	    visit edit_movie_url(movie)
	    fill_in "movie[title]", with: ""
	    click_on "Update Movie"

	    expect(page).to have_content("Title can't be blank")
	  end
	end
end