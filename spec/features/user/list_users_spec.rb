#app/views/users/index.html.erb

describe "Viewing List Of Users" do

	it "shows all users" do
		user1 = User.create(user_attributes)
		user2 = User.create(user_attributes(name: "Bob Sanders", username: "Bob12", email: "sandersbob@example.com"))

		login(user1)
		visit users_url

		expect(current_path).to eq(users_path)
		expect(page).to have_link(user1.name)
		expect(page).to have_link(user2.name)
	end
end