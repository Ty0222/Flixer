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

describe "#released_movies" do
  
  it "includes movie(s) when release date date is not beyond today" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.create(movie_attributes(title: "Deadpool", released_on: (Time.now).to_s))
    
    expect(Movie.released_movies).to include(movie1)
    expect(Movie.released_movies).to include(movie2)
  end
      
  it "does not include movie when 'released_on:' date is beyond today" do
    movie = Movie.create(movie_attributes(released_on: (Date.today+2).to_s))
  
    expect(Movie.released_movies).to_not include(movie)
  end
      
  it "returns movies in descending order (from most recent)" do
    movie1 = Movie.create(movie_attributes(released_on: Date.today-3))      
    movie2 = Movie.create(movie_attributes(title: "Deadpool", released_on: Date.today-2))      
    movie3 = Movie.create(movie_attributes(title: "Peter Pan", released_on: Date.today-1))      
  
    expect(Movie.released_movies).to eq([movie3, movie2, movie1])
  end
end

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
    user1 = User.create(user_attributes)
    user2 = User.create(user_attributes(name: "Sam Kelly"))

    review1 = movie.reviews.new(review_attributes)
    review1.user = user1

    review2 = movie.reviews.new(review_attributes)
    review2.user = user2

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes all of movie's associated reviews" do
    movie = Movie.create(movie_attributes)
    user1 = User.create(user_attributes)
    user2 = User.create(user_attributes(name: "Sam Kelly"))

    review1 = movie.reviews.new(review_attributes)
    review1.user = user1
    review1.save!

    review2 = movie.reviews.new(review_attributes)
    review2.user = user2
    review2.save!

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

  it "auto-generates a slug when created" do
    movie = Movie.create(movie_attributes(title: "X-Men: The Last Stand"))

    expect(movie.slug).to eq("x-men-the-last-stand")
  end

  it "requires a unique title" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.new(movie_attributes)

    movie2.valid?

    expect(movie2.errors[:title].first).to eq("has already been taken")
  end

  it "requires a unique slug" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.new(movie_attributes(slug: movie1.slug))

    movie2.valid?    

    expect(movie2.errors[:slug].first).to eq("has already been taken")
  end

  it "has many fans" do
    movie = Movie.new(movie_attributes)
    fan1 = User.new(user_attributes)
    fan2 = User.new(user_attributes(email: "sam@example.com"))

    movie.favorites.new(user: fan1)
    movie.favorites.new(user: fan2)

    expect(movie.fans).to include(fan1)
    expect(movie.fans).to include(fan2)
  end

  context "upcoming scope" do
    it "returns the movies with a released on date in the future" do
      movie1 = Movie.create!(movie_attributes(released_on: 3.months.ago))
      movie2 = Movie.create!(movie_attributes(title: "Deadpool", released_on: 3.months.from_now))

      expect(Movie.upcoming).to eq([movie2])
    end
  end

  context "rated scope" do
    it "returns released movies with the specified rating" do
      movie1 = Movie.create!(movie_attributes(released_on: 3.months.ago, rating: "PG"))
      movie2 = Movie.create!(movie_attributes(title: "Deadpool", released_on: 3.months.ago, rating: "PG-13"))
      movie3 = Movie.create!(movie_attributes(title: "Peter Pan", released_on: 1.month.from_now, rating: "PG"))

      expect(Movie.rated("PG")).to eq([movie1])
    end
  end

  context "recent scope" do
    
    before do
      @movie1 = Movie.create!(movie_attributes(released_on: 3.months.ago))
      @movie2 = Movie.create!(movie_attributes(title: "Deadpool", released_on: 2.months.ago))
      @movie3 = Movie.create!(movie_attributes(title: "Deadpool2", released_on: 1.month.ago))
      @movie4 = Movie.create!(movie_attributes(title: "Deadpool3", released_on: 1.week.ago))
      @movie5 = Movie.create!(movie_attributes(title: "Deadpool4", released_on: 1.day.ago))
      @movie6 = Movie.create!(movie_attributes(title: "Deadpool5", released_on: 1.hour.ago))
      @movie7 = Movie.create!(movie_attributes(title: "Deadpool6", released_on: 1.day.from_now))
    end

    it "returns a specified number of released movies ordered with the most recent movie first" do
      expect(Movie.recent(2)).to eq([@movie6, @movie5])
    end

    it "returns a default of 3 released movies ordered with the most recent movie first" do
      expect(Movie.recent).to eq([@movie6, @movie5, @movie4])
    end
  end

  context "all_from_genre scope" do

    it "shows only action movies" do
      movie1 = Movie.create(movie_attributes)
      movie2 = Movie.create(movie_attributes(title: "Deadpool"))

      genre = Genre.create(name: "Action")

      movie1.genres << genre
      movie2.genres << genre

      expect(Movie.all_from_genre(genre)).to eq([movie1, movie2])
    end
  end

end