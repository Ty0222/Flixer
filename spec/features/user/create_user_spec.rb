#app/views/users/new.html.erb & app/views/users/show.html.erb

describe "Creating A User" do

	it "saves a new user with a message of success"	do
		visit root_url

		click_on "Sign Up"

		expect(current_path).to eq(signup_path)

		fill_in "Full Name", with: "Billy Jean"
		fill_in "Username", with: "Jean12"
		fill_in "Email", with: "jeanbilly@example.com"
		fill_in "Password", with: "secret"
		fill_in "Confirm Password", with: "secret"
		
		click_button "Create Account"

		expect(current_path).to eq(user_path(User.last.username))
		
		expect(page).to have_content("Jean12")
		expect(page).to have_content("Account Settings")
		expect(page).to have_content("jeanbilly@example.com")
		expect(page).to have_content("Thanks for signing up!")
		expect(page).to have_link("Log Out")
		expect(page).not_to have_link("Log In")
		expect(page).not_to have_link("Sign Up")
	end

	it "does not save a user when invalid" do
		user = User.new(user_attributes(password: ""))

		visit movies_url
		click_on "Sign Up"

		expect(current_path).to eq(signup_path)

		expect { click_button "Create Account"
			}.not_to change(User, :count)
		expect(page).not_to have_content("Jean12")
		expect(page).not_to have_content("Thanks for signing up!")
		expect(page).to have_content("error")
	end
end