describe "Viewing Reviews" do
	
	it "lists a specific movie's reviews and reviewer info" do
		user1 = User.create(user_attributes)
		user2 = User.create(user_attributes(name: "Sam Kelly", email: "Sam@example.com", username: "Sam2222"))
		user3 = User.create(user_attributes(name: "Sam Hill", email: "SamH@example.com", username: "SamH2222"))

		movie1 = Movie.create(movie_attributes)
		
		review1 = movie1.reviews.new(review_attributes)
		review1.user = user1
		review1.save!

		review2 = movie1.reviews.new(review_attributes)
		review2.user = user2
		review2.save!

		movie2 = Movie.create(movie_attributes(title: "Deadpool"))
		review3 = movie2.reviews.new(review_attributes)
		review3.user = user3
		review3.save!

		visit movie_url(movie1)
		click_link "Reviews"
		
		expect(current_path).to eq(movie_reviews_path(movie1))
		expect(page).to have_content(review1.user.name)
		expect(page).to have_content(review2.user.name)
		expect(page).to have_content(review1.comment)
		expect(page).to_not have_content(review3.user.name)
	end

	it "links back to specific movie's page from reviews' page" do
		user = User.create(user_attributes)
		movie = Movie.create(movie_attributes)

		review = movie.reviews.new(review_attributes)
		review.user = user
		review.save!

		visit movie_reviews_url(movie)
		click_link "Iron Man 2"

		expect(current_path).to eq(movie_path(movie))
	end
end