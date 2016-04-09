describe "Editing A Genre" do

	before do
		@genre = Genre.create(name: "Genre 1")
		@user = User.create(user_attributes)
		login(@user)
		visit edit_genre_url(@genre)
	end
	
	context "when logged in as an admin" do
		
		it "updates the genre and shows details with message of success" do
			expect(find_field("Name").value).not_to eq(nil)

			fill_in "genre[name]", with: "Genre 2"
			click_button "Update Genre"

			expect(current_path).to eq(genres_path)
			expect(page).to have_content("Genre successfully updated!")
			expect(Genre.first.name).to eq("Genre 2")
		end

		it "does not update the genre when invalid" do
			fill_in "genre[name]", with: ""

			expect{
				click_button "Update Genre"
			}.not_to change(Genre, :count)
			expect(page).not_to have_content("Genre successfully updated!")
			expect(page).to have_content("error")
		end

	end

end