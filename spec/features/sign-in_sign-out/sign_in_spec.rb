describe "Signing In" do
	
	it "prompts for an email/username and password" do
		visit root_url
		
		click_link "Log In"

		expect(current_path).to eq(new_session_path)

		expect(page).to have_field("email")
		expect(page).to have_field("password")
		expect(page).not_to have_link("Log Out")
	end 

	it "accepts sign in request when valid and redirects to profile page with message of success" do
		user = User.create!(user_attributes)

		visit root_url

		click_link "Log In"

		fill_in "email", with: user.email
		fill_in "password", with: user.password

		click_button "Log In"

		expect(current_path).to eq(user_path(user.username))
		expect(page).to have_content("Welcome back Ty!")
		expect(page).to have_content("Ty0222")
		expect(page).to have_content("Account Settings")
		expect(page).to have_link("Log Out")
		expect(page).not_to have_link("Log In")
		expect(page).not_to have_link("Sign Up")
	end

	it "rejects sign in request when invalid and re-renders sign in form with message of denial" do
		user = User.create!(user_attributes)

		visit root_url

		click_link "Log In"

		fill_in "email", with: "sandersbob@example.com"
		fill_in "password", with: "lunch"
		
		click_button "Log In"

		expect(page).to have_field("password")
		expect(page).to have_content("Invalid email/username and/or password combination!")
	end

	it "redirects to the intended page" do
		user = User.create!(user_attributes)		

		visit users_url
		
		expect(current_path).to eq(login_path)

		login(user)

		expect(current_path).to eq(users_path)
	end
end