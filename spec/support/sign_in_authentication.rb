
def login(user)
	visit login_url
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "Log In"
end