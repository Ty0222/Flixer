require "rails_helper"

RSpec.feature "Navigating movies" do

  it "navigates between movie index pages" do 
    Movie.movie_list_source = ->(page) {[movie_list_data]}
    Movie.movie_list_metadata_source = ->(page) {movie_list_metadata(page: 1, total_pages: 30)}

    visit movies_url(page: 1)

    expect(page).to have_content("Page 1 of 30")
    expect(page).to have_link("Prev")
    expect(page).to have_link("Next")
    expect(page).to have_link("1")
    expect(page).to have_link("3")
    expect(page).to have_link("10")
    expect(page).not_to have_link("11")
    expect(page).to have_content("Iron Man 2")

    Movie.movie_list_metadata_source = ->(page) {movie_list_metadata(page: 10, total_pages: 30)}

    click_link "10"

    expect(page).to have_link("1")
    expect(page).to have_link("3")
    expect(page).not_to have_link("11")

    Movie.movie_list_metadata_source = ->(page) {movie_list_metadata(page: 11, total_pages: 30)}

    click_link "Next"

    expect(page).to have_content("Page 11 of 30")
    expect(page).to have_link("12")
    expect(page).to have_link("20")
    expect(page).not_to have_link("21")
  end

end