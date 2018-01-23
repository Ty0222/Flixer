require "rails_helper"

RSpec.describe MovieDecorator do

  include_examples "decorator interface"
  
  it "delegates all unknown messages to its underlying class" do
    decorator = MovieDecorator.new(double(foo: "bar"))

    expect(decorator.foo).to eq("bar")
  end

  it "responds to #title" do
    expect(described_class.new(double).respond_to?(:title)).to eq(true)  
  end

  it "responds to #release_date" do
    expect(described_class.new(double).respond_to?(:release_date)).to eq(true)  
  end

  it "responds to time_since_release_date" do
    expect(described_class.new(double).respond_to?(:time_since_release_date)).to eq(true)  
  end

  it "responds to star_rating" do
    expect(described_class.new(double).respond_to?(:star_rating)).to eq(true)  
  end

  it "responds to poster_image" do
    expect(described_class.new(double).respond_to?(:poster_image)).to eq(true)  
  end

  it "responds to #revenue" do
    expect(described_class.new(double).respond_to?(:revenue)).to eq(true)
  end

  it "responds to #duration" do
    expect(described_class.new(double).respond_to?(:duration)).to eq(true)
  end

  it "responds to #background_image" do
    expect(described_class.new(double).respond_to?(:background_image)).to eq(true)
  end

  it "responds to #hit_status" do
    expect(described_class.new(double).respond_to?(:hit_status)).to eq(true)
  end

  let(:view_context) { ActionView::Base.new }

  describe "#title" do

    it "returns a title" do
      movie = double(title: "MOVIE TITLE")
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.title(view_context)).to eq(movie.title)
    end
    
    context "when a movie title exceeds 25 characters" do  
      it "lowers the font size of the title" do
        movie = double(title: "This title has more than 18 characters")
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.title(view_context)).to include("font-size:16.5px")
      end
    end

    context "when there is no title" do  
      it "returns 'Not Available'" do
        movie = double(title: nil)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.title(view_context)).to include("N/A")
      end
    end
  end

  describe "#release_date" do

    it "returns a formatted date of when a given movie was released" do
      movie = double(released_on: "08-05-1989")
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.release_date).to eq("May 8th, 1989")
    end

    context "when there is no release date" do  
      it "returns 'N/A'" do
        movie = double(released_on: nil)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.release_date).to include("N/A")
      end
    end
  end

  describe "#time_since_release_date" do

    it "returns the time since a given movie was released" do
      movie = double(released_on: 3.months.ago)
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.time_since_release_date(view_context)).to eq("(3 months ago)")
    end

    context "when there is no release date" do  
      it "returns 'N/A'" do
        movie = double(released_on: nil)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.time_since_release_date(view_context)).to include("N/A")
      end
    end
  end

  describe "#star_rating" do

    context "when a movie has been voted on" do  
      it "returns an average number of stars via an HTML image based on a movie's vote rating" do
        movie = Movie.new(vote_rating: 7)
        view_context = double
        allow(view_context).to receive(:image_tag).with(any_args).and_return("*")
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.star_rating(view_context)).to eq("*******")
      end
    end

    context "when a movie has not been voted on" do  
      it "returns an HTML element with the text 'No rating'" do
        movie = Movie.new(vote_rating: 0)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.star_rating(view_context)).to include("No rating")
      end
    end
  end

  describe "#poster_image" do

    it "returns a movie's poster image inside an HTML image tag" do
      movie = double(image: "/new_image.png", id: 1)
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.poster_image(view_context)).to include(movie.image)
    end

    context "when there is no movie poster" do  
      it "returns a placeholder image" do
        movie = double(image: nil, id: 1)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.poster_image(view_context)).to include("poster-placeholder.png")
      end
    end
  end

  describe "#revenue" do

    context "when it is less than 1 million" do  
      it "returns a movie's revenue data in currency format" do
        movie = double(revenue: 200000)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.revenue(view_context)).to eq("$200,000.00")
      end
    end

    context "when it is greater than or equal to 1 million" do  
      it "returns a movie's revenue data in a more human-readable currency format" do
        movie = double(revenue: 1100000)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.revenue(view_context)).to eq("1.1 Million")
      end
    end

    context "when there is no revenue" do  
      it "returns 'N/A'" do
        movie = double(revenue: 0)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.revenue(view_context)).to include("N/A")
      end
    end
  end

  describe "#duration" do

    it "returns a movie's duration in minutes" do
      movie = double(duration: 140)
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.duration).to eq("140 minutes")
    end

    context "when there is no duration" do  
      it "returns 'N/A'" do
        movie = double(duration: 0)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.duration).to include("N/A")
      end
    end
  end

  describe "#background_image" do
    
    it "returns a movie's background poster image as the value for an HTML image" do
      movie = double(background_poster: "/background.png")
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.background_image(view_context)).to include(movie.background_poster)
    end

    context "when there is no movie background poster" do  
      it "returns a placeholder image" do
        movie = double(background_poster: nil, id: 1)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.background_image(view_context)).to include("secondary_bg.png")
      end
    end
  end

  describe "#hit_status" do

    it "returns the text 'Hit' inside an HTML element" do
      movie = double(hit_movie?: true)
      decorator = MovieDecorator.decorate(movie)

      expect(decorator.hit_status(view_context)).to include("HIT")
    end

    context "when a movie is not a hit" do  
      it "returns nil" do
        movie = double(hit_movie?: false)
        decorator = MovieDecorator.decorate(movie)

        expect(decorator.hit_status(view_context)).to eq(nil)
      end      
    end
  end

end