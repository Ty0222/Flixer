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

	it "shows a user's favorite movie(s) in the sidbar" do
		user = User.create(user_attributes)

		movie = Movie.create(movie_attributes)

		user.favorite_movies << movie

		login(user)

		visit user_url(user)

		within("aside#sidebar") do
			expect(page).to have_content(movie.title)
		end
	end

	it "includes a user's name in the page title tab" do
		user = User.create(user_attributes)

		login(user)

		visit user_url(user)

		expect(page).to have_title("Flixer - #{user.name}")
	end
end