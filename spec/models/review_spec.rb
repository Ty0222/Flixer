#app/models/review.rb

describe "A Review" do
	
	it " belongs to a movie" do
		movie = Movie.create(movie_attributes)
		review = movie.reviews.new(review_attributes)

		expect(review.movie).to eq(movie)
	end

	it "with example attributes is valid" do
		review = Review.new(review_attributes)

		expect(review.valid?).to eq(true)
	end

	it "requires a name" do
		review = Review.new(name: "")

		review.valid?

		expect(review.errors[:name].any?).to eq(true)
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
		stars = %w[0 -1 -2 6 22]

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