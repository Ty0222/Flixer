#app/views/layouts/_header.html.erb

describe "Signing Out" do
	
	it "signs user out of session and redirects to root url" do
		user = User.create!(user_attributes)

		sign_in(user)

		click_link "Sign Out"

		expect(current_path).to eq(root_path)
		expect(page).not_to have_link("Sign Out")
		expect(page).to have_link("Sign Up")
		expect(page).to have_link("Sign In")
		expect(page).to have_content("signed out")
	end
end