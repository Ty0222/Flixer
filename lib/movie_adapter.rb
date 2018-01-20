class MovieAdapter
  include HTTParty
  
  base_uri "api.themoviedb.org/3"

  def self.filter_by(queries = {})
    filtered_movie_data filtered_queries(queries)
  end

  def self.filter_metadata_by(queries = {})
    filtered_movie_metadata filtered_queries(queries)
  end

  def self.get_movie(id:)
    get("/movie/#{id}", default_options_hash) || {}
  end


  private

    def self.filtered_movie_data(queries)
      all_filtered_movie_data(queries)["results"] || []
    end

    def self.filtered_movie_metadata(queries)
      all_filtered_movie_data(filtered_queries(queries)).reject { |el| el == "result" } || {}
    end

    def self.all_filtered_movie_data(queries = {})
      get("/discover/movie", combine_queries(queries))
    end

    def self.filtered_queries(queries)
      return queries.merge!(hit_status_scope) if queries[:hit_status] == true || queries[:hit_status] == "true"
      queries
    end

    def self.combine_queries(queries)
      default_options_hash.tap { |opts| opts[:query].merge!(now_playing_scope).merge!(queries) }
    end

    def self.default_options_hash
      { query: { api_key: api_key } }
    end

    def self.hit_status_scope
      {
        "vote_count.gte" => 100,
        "vote_average.gte" => 6.5
      }
    end

    def self.now_playing_scope
      {
        "with_release_type" => 2|3, 
        "primary_release_date.lte" => Date.today + 1.week, 
        "primary_release_date.gte" => Date.today - 12.weeks,
        page: 1
      }
    end

    def self.api_key
      ENV["MOVIE_API_KEY"]
    end

end