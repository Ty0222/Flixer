
describe "#flop?" do
  
  context "when movie total gross is less than 50M" do
  	it "is a flop" do
  	  movie = Movie.new(total_gross: 40000000.0)

  	  expect(movie.flop?).to eq(true)
  	end
  end

  context "when movie total gross is greater than 50M" do
  	it "is not a flop" do
	  movie = Movie.new(total_gross: 60000000.0)
	  
	  expect(movie.flop?).to eq(false)
  	end
  end

  context "when movie total gross is blank" do
  	it "is a flop" do
	  movie = Movie.new(total_gross: nil)
	  
	  expect(movie.flop?).to eq(true)
  	end
  end
end