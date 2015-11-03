#app/views/layouts/_header.html.erb

describe "Signing Out" do
	
	it "signs user out of session and redirects to root url" do
		user = User.create!(user_attributes)

		login(user)

		click_link "Log Out"

		expect(current_path).to eq(root_path)
		expect(page).not_to have_link("Log Out")
		expect(page).to have_link("Sign Up")
		expect(page).to have_link("Log In")
		expect(page).to have_content("logged out")
	end
end