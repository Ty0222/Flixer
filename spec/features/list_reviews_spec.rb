#app/views/reviews/index.html.erb

describe "Viewing Reviews" do
	
	it "lists a specific movie's reviews and reviewer info" do
		movie1 = Movie.create(movie_attributes)
		review1 = movie1.reviews.create(review_attributes)
		review2 = movie1.reviews.create(review_attributes(name: "Ty Kelly"))

		movie2 = Movie.create(movie_attributes(title: "Deadpool"))
		review3 = movie2.reviews.create(review_attributes(name: "Mike Myers"))
		
		visit movie_url(movie1)
		click_link "Reviews"
		
		expect(current_path).to eq(movie_reviews_path(movie1))
		expect(page).to have_content(review1.name)
		expect(page).to have_content(review2.name)
		expect(page).to have_content(review1.comment)
		expect(page).to have_content(review2.location)
		expect(page).to have_content(review1.stars)
		expect(page).to_not have_content(review3.name)
	end

	it "links back to specific movie's page from reviews' page" do
		movie = Movie.create(movie_attributes)
		movie.reviews.create(review_attributes)

		visit movie_reviews_url(movie)
		click_link "Iron Man 2"

		expect(current_path).to eq(movie_path(movie))
	end
end