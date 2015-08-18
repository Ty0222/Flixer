describe "Creating A New Movie" do
	
	context "when user clicks 'Add New Movie' link" do
		it "shows new movie form" do

			visit movies_url
			click_link "Add New Movie"

			expect(current_path).to eq(new_movie_path)
			expect(find_field("Title").value).to eq(nil)
		end
	end

	context "when user fills out form and clicks 'Add' button" do
		it "redirects to movie page with newly created details" do
			
			visit movies_url
			click_link "Add New Movie"		
			
			fill_in "Title", with: "Deadpool"
			fill_in "Rating", with: "R"
			fill_in "Worldwide Gross", with: "100000000"
			fill_in "Description", with: "A bad ass movie"
			select "2015", from: "movie_released_on_1i"

			click_button "Add"

			expect(current_path).to eq(movie_path(Movie.last))
			expect(page).to have_content("Deadpool")
		end
	end
end