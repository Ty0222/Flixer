describe "Listing Genres" do

	before do
		@genre1 = Genre.create(name: "Genre 1")
		@genre2 = Genre.create(name: "Genre 2")
		@genre3 = Genre.create(name: "Genre 3")
		@user = User.create(user_attributes)
		login(@user)
		visit genres_url
	end
	
	it "shows all genres" do
		
		expect(page).to have_link(@genre1.name)
		expect(page).to have_link(@genre2.name)
		expect(page).to have_link(@genre3.name)
		expect(page).to have_link("Edit")
	end

end