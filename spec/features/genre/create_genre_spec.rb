describe "Creating A Genre" do

	before do
		@user = User.create(user_attributes)
		login(@user)
		visit new_genre_url
	end
	
	context "when logged as an admin" do
		# add expect(current_path).to eq(genres_path)
		it "saves a new genre with message of success" do
			expect(current_path).to eq(new_genre_path)
			expect(find_field("Name").value).to eq(nil)

			fill_in "Name", with: "Horror"
			click_button "Add Genre"

			expect(current_path).to eq(root_path)
			expect(page).to have_content("New genre added!")
		end

		it "does not save a genre when invalid" do
			fill_in "Name", with: ""

			expect(page).not_to have_content("New Genre Added!")
			expect{
				click_button "Add Genre"
			}.not_to change(Genre, :count)

			expect(page).to have_content("error")
		end
	
	end

end