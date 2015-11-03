#app/views/users/new.html.erb & #app/views/show.html.erb

describe "Signing In" do
	
	it "prompts for an email/username and password" do
		visit root_url
		
		click_link "Sign In"

		expect(current_path).to eq(new_session_path)

		expect(page).to have_field("Email")
		expect(page).to have_field("Password")
		expect(page).not_to have_link("Sign Out")
	end 

	it "accepts sign in request when valid and redirects to profile page with message of success" do
		user = User.create!(user_attributes)

		visit root_url

		click_link "Sign In"

		fill_in "Email", with: user.email
		fill_in "Password", with: user.password

		click_button "Sign In"

		expect(current_path).to eq(user_path(user))
		expect(page).to have_content("Welcome back Ty!")
		expect(page).to have_content("Ty0222")
		expect(page).to have_content("Account Settings")
		expect(page).to have_link("Sign Out")
		expect(page).not_to have_link("Sign In")
		expect(page).not_to have_link("Sign Up")
	end

	it "rejects sign in request when invalid and re-renders sign in form with message of denial" do
		user = User.create!(user_attributes)

		visit root_url

		click_link "Sign In"

		fill_in "Email", with: "sandersbob@example.com"
		fill_in "Password", with: "lunch"
		
		click_button "Sign In"

		expect(page).to have_field("Password")
		expect(page).to have_content("Invalid email/username and/or password combination!")
	end
end