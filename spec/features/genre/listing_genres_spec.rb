require "rails_helper"

RSpec.feature "Listing genres" do
	
	it "displays a collection of genres" do
		Genre.genre_list_source = -> {[genre_list_data, genre_list_data(name: "Adventure")]}

		visit genres_url

		expect(page).to have_link("Action")
		expect(page).to have_link("Adventure")
	end

end