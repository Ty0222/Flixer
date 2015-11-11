describe "Editing A User" do

	before { @user = User.create(user_attributes(admin: false)) }
	
	it "updates the user and shows the user's updated details with message of success" do
		login(@user)		

		visit edit_user_url(@user.username)

		fill_in "Full Name", with: @user.name
		fill_in "Username", with: @user.username
		fill_in "Email", with: @user.email
		click_button "Update Account"

		expect(current_path).to eq(user_path(@user.username))
		expect(page).to have_content(@user.username)		
		expect(page).to have_content(@user.email)
		expect(page).to have_content("Account successfully updated!")		
	end

	it "does not update the user and returns error messages when invalid" do
		login(@user)
		visit edit_user_url(@user)

		fill_in "Name", with: ""
		click_button "Update Account"
		
		expect(page).not_to have_content("Jean12")
		expect(page).to have_content("error")		
	end

	it "does not update a user when not current user" do
		user2 = User.create(user_attributes(name: "Sam Wise", email: "sw636@example.com", username: "SW636"))		

		login(@user)
		visit edit_user_url(user2)

		expect(current_path).to eq(users_path)
		expect(page).to have_link("Ty0222")
		expect(page).to have_content("You do not have permission to do that!")

	end
end