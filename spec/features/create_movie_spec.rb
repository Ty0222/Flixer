describe "Creating A New Movie" do
	
	it "shows new movie form and redirects to movie url with message of success" do
		visit movies_url
		
		click_link "Add New Movie"		
		
		expect(current_path).to eq(new_movie_path)
		expect(find_field("Title").value).to eq(nil)

		fill_in "Title", with: "The Amazing Spider-Man"
		select "R", from: "movie_rating"
		fill_in "Worldwide Gross", with: "100000000"
		fill_in "Description", with: "A 'bad ass' movie bound to give you many laughs"
		select "2015", from: "movie_released_on_1i"
		select "July", from: "movie_released_on_2i"
		select "1", from: "movie_released_on_3i"
		fill_in "Cast", with: "Ryan Reynolds"
		fill_in "Director", with: "Tim Miller"
		fill_in "Duration", with: "123 min"
		attach_file "Image", "#{Rails.root}/app/assets/images/spiderman.jpg"

		click_on "Create Movie"

		expect(current_path).to eq(movie_path(Movie.last))
		expect(page).to have_content("Movie successfully created!")
		expect(page).to have_content("The Amazing Spider-Man")
	end

	it "returns error message(s) when required data is not filled in" do
    movie = Movie.new(movie_attributes(title: ""))

    visit new_movie_url

    click_on "Create Movie"

    expect(page).to have_content("Title can't be blank")
  end
end