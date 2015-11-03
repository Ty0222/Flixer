#app/views/users/show.html.erb

describe "Viewing An Individual User Account" do
	
	it "shows a user's details" do
		user = User.create(user_attributes)

		login(user)
		visit user_url(user)

		expect(current_path).to eq(user_path(user))
		expect(page).to have_content(user.username)
		expect(page).to have_content(user.email)
	end
end