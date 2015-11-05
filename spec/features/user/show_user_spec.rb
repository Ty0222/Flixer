#app/views/users/show.html.erb

describe "Viewing An Individual User Account" do
	
	it "shows a user's details" do
		user = User.create(user_attributes)
		movie = Movie.create(movie_attributes)
		review = movie.reviews.new(review_attributes)
		review.user = user
		review.save!
		review.update_attribute(:created_at, 1.month.ago)

		login(user)
		visit user_url(user)

		expect(current_path).to eq(user_path(user))
		expect(page).to have_content(user.username)
		expect(page).to have_content(user.email)
		expect(page).to have_link(review.movie.title)
		expect(page).to have_content("3 Stars")
		expect(page).to have_content("About 1 month ago")
		expect(page).to have_content(review.comment)
	end
end