#app/views/users/show.html.erb & app/views/movies/index.html.erb

describe "Deleting A User" do
	
	it "Removes and signs a user out with message of success and redirects to home page" do
		user = User.create(user_attributes)

		visit user_url(user)

		click_link "Delete Account"

		expect(current_path).to eq(root_path)		
		expect(page).to have_content("Account successfully deleted!")
		expect(page).not_to have_link("Sign Out")

		visit users_url

		expect(page).not_to have_content(user.name)
	end
end