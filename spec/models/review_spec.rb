#app/models/review.rb

describe "A Review" do
	
	it "belongs to a movie" do
		movie = Movie.create(movie_attributes)
		review = movie.reviews.new(review_attributes)

		expect(review.movie).to eq(movie)
	end

	it "belongs to a user" do
		user = User.create(user_attributes)
		review = user.reviews.new(review_attributes)

		expect(review.user).to eq(user)
	end 

	it "accepts valid entry of data" do
		review = Review.new(review_attributes)

		expect(review.valid?).to eq(true)
	end

	it "accepted an approved star rating" do
		stars = [1, 2, 3, 4, 5]

		stars.each do |star|
			review = Review.new(stars: star)

			review.valid?

			expect(review.errors[:stars].any?).to eq(false)
		end

		
	end

	it "rejects unapproved star ratings" do
		stars = [0, -1, -2, 6, 22]

		stars.each do |star|
			review = Review.new(stars: star)
			
			review.valid?

			expect(review.errors[:stars].any?).to eq(true)
			expect(review.errors[:stars].first).to eq("must be between 1 and 5")
		end
	end

	it "requires a comment" do
		review = Review.new(comment: "")

		review.valid?

		expect(review.errors[:comment].any?).to eq(true)
	end

	it "requires a comment over 3 characters" do
		review = Review.new(comment: "X" * 2)

		review.valid?

		expect(review.errors[:comment].any?).to eq(true)
	end

end