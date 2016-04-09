describe "Creating Review For A Movie" do
	
	before { @user = User.create(user_attributes) }
	
	context "when user is logged in" do
	
		it "saves the review" do
			movie = Movie.create(movie_attributes)

			login(@user)
			visit movie_url(movie)
			click_link "Write Review"

			expect(current_path).to eq(new_movie_review_path(movie))

			select 3, from: "review_stars"
			fill_in "review[comment]", with: "I laugh, I cried, I spilled my popcorn!"
			click_button "Post Review"		

			expect(current_path).to eq(movie_reviews_path(movie))
			expect(page).to have_content("Thanks for your review!")
		end

		it "does not save review and returns error messages when invalid" do
			movie = Movie.create(movie_attributes)

			login(@user)
			visit new_movie_review_url(movie)

			expect {
				click_button "Post Review"
			}.not_to change(Review, :count)

			expect(page).to have_content("error")
		end
	end
end