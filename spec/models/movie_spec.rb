#app/helpers/movies_helper.rb

describe "#flop?" do
  
	it "is a flop when movie total gross is less than 50M" do
	  movie = Movie.new(total_gross: 40000000.0)
    movie.reviews.new(review_attributes(stars: 3))
    movie.reviews.new(review_attributes(stars: 3))
    movie.reviews.new(review_attributes(stars: 3))
    movie.reviews.new(review_attributes(stars: 3))
    movie.reviews.new(review_attributes(stars: 3))
    movie.reviews.new(review_attributes(stars: 2))
    movie.reviews.new(review_attributes(stars: 2))
    movie.reviews.new(review_attributes(stars: 2))
    movie.reviews.new(review_attributes(stars: 2))
    
    expect(movie.flop?).to eq(true)
	end

	it "is not a flop when movie total gross is greater than 50M" do
    movie = Movie.new(total_gross: 60000000.0)
  
    expect(movie.flop?).to eq(false)
  end

	it "is a flop when movie total gross is blank" do
    movie = Movie.new(total_gross: nil)
  
    expect(movie.flop?).to eq(true)
	end
end

#app/models/movie.rb

describe "#released_movies" do
  
  it "includes movie(s) when release date date is not beyond today" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.create(movie_attributes(released_on: (Time.now).to_s))
    
    expect(Movie.released_movies).to include(movie1)
    expect(Movie.released_movies).to include(movie2)
  end
      
  it "does not include movie when 'released_on:' date is beyond today" do
    movie = Movie.create(movie_attributes(released_on: (Date.today+2).to_s))
  
    expect(Movie.released_movies).to_not include(movie)
  end
      
  it "returns movies in descending order (from most recent)" do
    movie1 = Movie.create(movie_attributes(released_on: Date.today-3))      
    movie2 = Movie.create(movie_attributes(released_on: Date.today-2))      
    movie3 = Movie.create(movie_attributes(released_on: Date.today-1))      
  
    expect(Movie.released_movies).to eq([movie3, movie2, movie1])
  end
end

#app/models/movie.rb

describe "A Movie" do
  
  it "requires a title" do
    movie = Movie.new(movie_attributes(title: ""))

    movie.valid?

    expect(movie.errors[:title].any?).to eq(true)
  end

  it "requires a rating" do
    movie = Movie.new(movie_attributes(rating: ""))

    movie.valid?

    expect(movie.errors[:rating].any?).to eq(true)
  end

  it "requires a description" do
    movie = Movie.new(movie_attributes(description: ""))

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "requires a duration" do
    movie = Movie.new(movie_attributes(duration: ""))

    movie.valid?

    expect(movie.errors[:duration].any?).to eq(true)
  end

  it "requires a description to be longer than 24 characters" do
    movie = Movie.new(movie_attributes(description: "X" * 24))

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "accepts a total gross of 0" do
    movie = Movie.new(movie_attributes(total_gross: 0.00))

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end
  
  it "accepts a positive total gross" do
      movie = Movie.new(movie_attributes(total_gross: 1.00))

      movie.valid?

      expect(movie.errors[:total_gross].any?).to eq(false)
    end

  it "rejects a negative total gross" do
    movie = Movie.new(movie_attributes(total_gross: -24.0))

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(true)
  end
  
  it "accepts any ratings on the approved list" do
    ratings = %w[G PG PG-13 R NC-17]

    ratings.each do |rating|
      movie = Movie.new(movie_attributes(rating: rating))

      movie.valid?

      expect(movie.errors[:rating].any?).to eq(false)
    end
  end
  
  it "rejects any ratings not on allowed list" do
    ratings = %w[R-18 F R0 P2 Help]

    ratings.each do |rating|
      movie = Movie.new(movie_attributes(rating: rating))

      movie.valid?

      expect(movie.errors[:rating].any?).to eq(true)
    end
  end

  it "accepts valid entry of data" do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to eq(true)
  end  

  it "has many reviews" do
    movie = Movie.new(movie_attributes)
    
   review1 = movie.reviews.new(review_attributes)
   review2 = movie.reviews.new(review_attributes(name: "Ty Kelly"))

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes all of movie's associated reviews" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes)
    movie.reviews.create(review_attributes(name: "Ty Kelly"))

    expect {
      movie.destroy
      }.to change(Review, :count).by(-2) 
  end

  it "calculates the average number of stars" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))

    expect(movie.average_stars).to eq(2)
  end
end