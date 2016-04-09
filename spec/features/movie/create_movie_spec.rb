describe "Creating A New Movie" do

	context "when admin user" do

		before do
			@user = User.create(user_attributes)
			@genre1 = Genre.create(name: "Genre 1")
			@genre2 = Genre.create(name: "Genre 2")
			@genre3 = Genre.create(name: "Genre 3")
			login(@user)
		end
		
		it "saves a new movie with message of success" do

			visit movies_url
			
			click_link "Add New Movie"		
			
			expect(current_path).to eq(new_movie_path)
			expect(find_field("Title").value).to eq(nil)

			fill_in "movie[title]", with: "The Amazing Spider-Man"
			select "R", from: "movie_rating"
			fill_in "movie[total_gross]", with: "100000000"
			fill_in "movie[description]", with: "A 'bad ass' movie bound to give you many laughs"
			select "2015", from: "movie_released_on_1i"
			select "July", from: "movie_released_on_2i"
			select "1", from: "movie_released_on_3i"
			fill_in "movie[cast]", with: "Ryan Reynolds"
			fill_in "movie[director]", with: "Tim Miller"
			fill_in "movie[duration]", with: "123 min"
			attach_file "movie[image]", "#{Rails.root}/app/assets/images/spiderman.jpg"
			check(@genre1.name)
			check(@genre2.name)

			click_on "Create Movie"

			expect(current_path).to eq(movie_path(Movie.last))
			expect(page).to have_content("Movie successfully created!")
			expect(page).to have_content("The Amazing Spider-Man")
			expect(page).to have_content(@genre1.name)
			expect(page).to have_content(@genre2.name)
			expect(page).not_to have_content(@genre3.name)
		end

		it "does not save movie and returns error message(s) when invalid" do
	    movie = Movie.new(movie_attributes(title: ""))

	    visit new_movie_url

	    click_on "Create Movie"

	    expect(page).to have_content("Title can't be blank")
	  end
	end
end