require "rails_helper"

RSpec.describe "Showing a movie" do
  
  it "shows a movie with its details" do
    Movie.movie_fetcher = ->(id) { movie_data(id: 2) }
  
  	visit movie_url(2)

  	expect(page).to have_content("Iron Man 2")
  	expect(page).to have_selector("img[src$='iron_man2.jpg']")
  	expect(page).to have_content("This is an overview")
  	expect(page).to have_content("May 7th, 2010")
    expect(page).to have_content("152 minutes")
    expect(page).to have_content("Action")
    expect(page).to have_content("Adventure")
  end

  it "shows a movie's title within the title tab of a given browser" do
    Movie.movie_fetcher = ->(id) { movie_data(id: 2) }
  
    visit movie_url(2)

    expect(page).to have_title("Flixer - Iron Man 2")
  end

end