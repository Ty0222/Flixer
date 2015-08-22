describe "Deleting A Movie" do
	
	it "removes that movie from and redirects to listing page with message of success" do
		movie = Movie.create(movie_attributes)

		visit movie_url(movie)
		click_link "Delete"

		expect(current_path).to eq(movies_path)
		expect(page).to_not have_content(movie.title)
		expect(page).to have_content("Movie successfully deleted!")
	end
end