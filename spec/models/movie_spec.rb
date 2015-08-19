#app/helpers/movies_helper.rb

describe "#flop?" do
  
	it "is a flop when movie 'total gross:' is less than 50M" do
	  movie = Movie.new(total_gross: 40000000.0)

    expect(movie.flop?).to eq(true)
	end

	it "is not a flop when movie 'total gross:' is greater than 50M" do
    movie = Movie.new(total_gross: 60000000.0)
  
    expect(movie.flop?).to eq(false)
  end

	it "is a flop when movie 'total gross:' is blank" do
    movie = Movie.new(total_gross: nil)
  
    expect(movie.flop?).to eq(true)
	end
end

#app/models/movie.rb

describe "#released_movies" do
  
  it "includes movie(s) when 'released_on:' date is not beyond today" do
    movie1 = Movie.create(movie_attributes)
    movie2 = Movie.create(movie_attributes(released_on: Date.today.to_s))
    
    expect(Movie.released_movies).to include(movie1)
    expect(Movie.released_movies).to include(movie2)
  end
      
  it "does not include movie when 'released_on:' date is beyond today" do
    movie = Movie.create(movie_attributes(released_on: (Date.today+1).to_s))    
  
    expect(Movie.released_movies).to_not include(movie)
  end
      
  it "returns movies in descending order (from most recent)" do
    movie1 = Movie.create(movie_attributes(released_on: (Date.today-3).to_s))      
    movie2 = Movie.create(movie_attributes(released_on: (Date.today-2).to_s))      
    movie3 = Movie.create(movie_attributes(released_on: (Date.today-1).to_s))      
  
    expect(Movie.released_movies).to eq([movie3, movie2, movie1])
  end
end