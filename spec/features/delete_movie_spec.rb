describe "Deleting A Movie" do
	
	context "when user clicks 'Delete' to remove movie from listing" do
		it "removes that movie from listing and redirects to listing page" do
			movie = Movie.create(movie_attributes)

			visit movie_url(movie)
			click_link "Delete"

			expect(current_path).to eq(movies_path)
			expect(page).to_not have_content(movie.title)
		end
	end
end