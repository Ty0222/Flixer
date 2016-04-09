describe "Unfavoriting A Movie" do
	
	before do
		@user = User.create!(user_attributes)
		login(@user)
	end

	it "unfavorites a movie for current user and shows Favorite button" do
		movie = Movie.create!(movie_attributes)
		
		visit movie_url(movie)

		find(".fav-btn a").click

		expect(page).to have_content("1 Fan")
		expect(page).to have_css(".unfav")

		expect {
			find(".fav-btn a").click
		}.to change(@user.favorites, :count).by(-1)

		expect(current_path).to eq(movie_path(movie))
		expect(page).to have_content("0 Fans")
		expect(page).not_to have_content("1 Fan")
		expect(page).to have_css(".fav")
		expect(page).not_to have_button("Unfavorite")
	end

end