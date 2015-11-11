#app/models/user.rb

describe "A User" do
	
	it "requires a name" do
		user = User.new(user_attributes(name: ""))		

		user.valid?

		expect(user.errors[:name].any?).to eq(true)
	end

	it "requires a username" do
		user = User.new(user_attributes(username: ""))

		user.valid?

		expect(user.errors[:username].any?).to eq(true)
	end

	it "requires an email" do
		user = User.new(user_attributes(email: ""))		
		
		user.valid?

		expect(user.errors[:email].any?).to eq(true)
	end
	
	it "requires a password" do
		user = User.new(user_attributes(password: ""))
	
		user.valid?

		expect(user.errors[:password].any?).to eq(true)
	end
	
	it "requires a unique, case insensitive email" do
		user1 = User.create!(user_attributes)
		user2 = User.new(email: user1.email.upcase)

		user2.valid?

		expect(user2.errors[:email].first).to eq("has already been taken")
	end

	it "requires a unique, case insensitive username" do
		user1 = User.create(user_attributes)
		user2 = User.create(user_attributes(username: "Ty0222"))

		user2.valid?

		expect(user2.errors[:username].first).to eq("has already been taken")
	end
	
	it "requires a password confirmation when password is present" do
		user = User.new(user_attributes(password_confirmation: ""))

		user.valid?

		expect(user.errors[:password_confirmation].any?).to eq(true)
	end
	
	it "requires a match between password and password confirmation" do
		user = User.new(password: "secret", password_confirmation: "nomatch")
	
		user.valid?

		expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
	end
	
	it "accepts a password and password confirmation when creating account if they match" do
		user = User.new(user_attributes(password: "secret", password_confirmation: "secret"))
	
		expect(user.valid?).to eq(true)
	end

	it "does not require a password when updating account" do
		user = User.create!(user_attributes)

		user.password = ""

		expect(user.valid?).to eq(true)
	end
	
	it "accepts properly formatted email" do
		emails = %w[hello@gmail.com first.name@example.com ]

		emails.each do |email|
			user = User.new(user_attributes(email: email))

			user.valid?

			expect(user.errors[:email].any?).to eq(false)
		end
	end
	
	it "rejects improperly formatted email" do
		emails = %w[ @example.com @ hello@ ]

		emails.each do |email|
			user = User.new(user_attributes(email: email))
			
			user.valid?

			expect(user.errors[:email].any?).to eq(true)
		end
	end

	it "automatically encrypts password into the password_digest attribute" do
		user = User.new(password: "secret")

		expect(user.password_digest.present?).to eq(true)
	end
	
	it "accepts valid user information" do
		user = User.new(user_attributes)

		expect(user.valid?).to eq(true)
	end

	it "has many reviews" do
		user = User.new(user_attributes)	
		movie1 = Movie.new(movie_attributes(title: "Iron Man"))
		movie2 = Movie.new(movie_attributes(title: "Spider-Man"))

		review1 = movie1.reviews.new(comment: "Awesome!", stars: 5)
		review1.user = user
		review1.save!

		review2 = movie2.reviews.new(comment: "Cool", stars: 4)
		review2.user = user
		review2.save!

		expect(user.reviews).to include(review1)
		expect(user.reviews).to include(review2)
	end

	it "has many favorite movies" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes)
    movie2 = Movie.new(movie_attributes(title: "Deadpool"))

    user.favorites.new(movie: movie1)
    user.favorites.new(movie: movie2)
    
    expect(user.favorite_movies).to include(movie1)
    expect(user.favorite_movies).to include(movie2)
  end

  context "non_admins scope" do
  	
  	it "shows only non admin users in alphabetical order" do
  		admin = User.create(user_attributes)
  		user1 = User.create(user_attributes(name: "Al", email: "norm1@example.com", username: "N0223", admin: false))
  		user2 = User.create(user_attributes(name: "Sal", email: "norm2@example.com", username: "N0224", admin: false))

  		expect(User.non_admins).to eq([user1, user2])
  	end
  end

end