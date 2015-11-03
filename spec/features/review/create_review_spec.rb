#app/views/reviews/new.html.erb & app/views/movies/show.html.erb

describe "Creating Review For A Movie" do
	
	it "saves the review" do
		movie = Movie.create(movie_attributes)

		visit movie_url(movie)
		click_link "Write Review"

		expect(current_path).to eq(new_movie_review_path(movie))

		fill_in "Name", with: "Ty Kelly"
		select 3, from: "review_stars"
		fill_in "Comment", with: "I laugh, I cried, I spilled my popcorn!"
		click_button "Post Review"		

		expect(current_path).to eq(movie_reviews_path(movie))
		expect(page).to have_content("Thanks for your review!")
	end

	it "does not save review and returns error messages when invalid" do
		movie = Movie.create(movie_attributes)

		visit new_movie_review_url(movie)

		expect {
			click_button "Post Review"
		}.not_to change(Review, :count)

		expect(page).to have_content("error")
	end
end