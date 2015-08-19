describe "Creating A New Movie" do
	
	it "shows new movie form when user clicks 'Add New Movie' link" do

		visit movies_url
		click_link "Add New Movie"

		expect(current_path).to eq(new_movie_path)
		expect(find_field("Title").value).to eq(nil)
	end

	it "redirects to movie_url when user fills out form and clicks 'Create Movie' button" do
		
		visit movies_url
		click_link "Add New Movie"		
		
		fill_in "Title", with: "Deadpool"
		fill_in "Rating", with: "R"
		fill_in "Worldwide Gross", with: "100000000"
		fill_in "Description", with: "A 'bad' ass movie"
		select "2015", from: "movie_released_on_1i"
		fill_in "Cast", with: "Ryan Reynolds"
		fill_in "Director", with: "Tim Miller"
		fill_in "Duration", with: "123 min"
		fill_in "Image File", with: "deadpool.png"

		click_button "Create Movie"

		expect(current_path).to eq(movie_path(Movie.last))
	end
end