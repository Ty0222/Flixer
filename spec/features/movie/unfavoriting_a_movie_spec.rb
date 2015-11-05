describe "Unfavoriting A Movie" do
	
	before do
		@user = User.create!(user_attributes)
		login(@user)
	end

	it "unfavorites a movie for current user and shows Favorite button" do
		movie = Movie.create!(movie_attributes)
		
		visit movie_url(movie)

		click_button "Favorite"

		expect(page).to have_content("1 Fan")

		expect {
			click_button "Unfavorite"
		}.to change(@user.favorites, :count).by(-1)

		expect(current_path).to eq(movie_path(movie))
		expect(page).to have_content("0 Fans")
		expect(page).not_to have_content("1 Fan")
		expect(page).to have_button("Favorite")
		expect(page).not_to have_button("Unfavorite")
	end

end