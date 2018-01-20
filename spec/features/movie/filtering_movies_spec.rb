require "rails_helper"

RSpec.feature "Filtering movies" do

  context "when clicking one of the genre categories listed under a given movie" do  
    it "displays a listing of movies associated with that genre" do
      action_movie1 = movie_data(id: 1, title: "Iron Man 2", genre_ids: [21], genres: [{id: 21, name: "Action"}])
      action_movie2 = movie_data(id: 2, title: "Batman Returns", genre_ids: [21], genres: [{id: 21, name: "Action"}])
      horror_movie = movie_data(id: 3, title: "Halloween", genre_ids: [12], genres: [{id: 12, name: "Horror"}])

      Movie.movie_fetcher = ->(id) {action_movie1}
      
      visit movie_url(1)

      Movie.filtered_movie_list_source = ->(genre_ids) {[action_movie1, action_movie2]}
      Movie.filtered_movie_list_metadata_source = ->(genre_ids) {movie_list_metadata(page: 2)}
      
      click_link "Action"

      expect(current_path).to eq(filtered_movies_by_genre_path(genre_ids: [21]))
      expect(page).to have_content("Iron Man 2")
      expect(page).to have_content("Batman Returns")
      expect(page).not_to have_content("Halloween")
    end
  end

end