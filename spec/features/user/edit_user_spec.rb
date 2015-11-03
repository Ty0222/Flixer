#app/views/users/edit.html.erb 

describe "Editing A User" do
	
	it "updates the user and shows the user's updated details with message of success" do
		user = User.create(user_attributes)

		visit users_url
		click_link "Ty Kelly"

		expect(current_path).to eq(user_path(user))

		click_link "Edit Account"

		fill_in "Full Name", with: "Billy Jean"
		fill_in "Username", with: "Jean12"
		fill_in "Email", with: "jeanbilly@example.com"
		click_button "Update Account"

		expect(current_path).to eq(user_path(user))
		expect(page).to have_content("Jean12")		
		expect(page).to have_content("jeanbilly@example.com")
		expect(page).to have_content("Account successfully updated!")		
	end

	it "does not update the user and returns error messages when invalid" do
		user = User.create(user_attributes)

		visit edit_user_url(user)

		fill_in "Name", with: ""
		click_button "Update Account"
		
		expect(page).not_to have_content("Jean12")
		expect(page).to have_content("error")		
	end
end