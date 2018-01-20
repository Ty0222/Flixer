class GenreAdapter
  include HTTParty

  base_uri "api.themoviedb.org/3"

  def self.all_genres
    get("/genre/movie/list", default_options_hash)["genres"] || []
  end

  private

    def self.default_options_hash
      { query: { api_key: api_key } }
    end

    def self.api_key
       ENV["MOVIE_API_KEY"]
    end

end