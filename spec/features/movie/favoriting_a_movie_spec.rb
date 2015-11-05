describe "Favoriting A Movie" do
	
	before do
		@user = User.create!(user_attributes)
		login(@user)
	end

	it "creates a favorite for current user and shows Unfavorite button" do
		movie = Movie.create!(movie_attributes)

		visit movie_url(movie)

		expect(page).to have_content("0 Fans")

		expect {
			click_button "Favorite"
		}.to change(@user.favorites, :count).by(1)

		expect(current_path).to eq(movie_path(movie))
		expect(page).to have_content("1 Fan")
		expect(page).to have_button("Unfavorite")
		expect(page).not_to have_button("Favorite")
	end

end