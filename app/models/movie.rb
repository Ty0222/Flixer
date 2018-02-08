class Movie
	include ActiveModelNaming
	include DataAccess::Builder

	attr_reader :id, :title, :image, :released_on, :vote_rating, :total_votes, :overview, :revenue, :duration, :background_poster,
	 :genres, :genre_ids

	movie_list_mappings = { 
		id: "id", title: "title", image: "poster_path", released_on: "release_date", vote_rating: "vote_average", total_votes: "vote_count",
		 overview: "overview", genre_ids: "genre_ids" 
	}

	movie_mappings = {
		revenue: "revenue", duration: "runtime", background_poster: "backdrop_path", genres: "genres"
	}.merge(movie_list_mappings)


	builds_object :movie_list, mappings: movie_list_mappings
	builds_object :movie, mappings: movie_mappings

	# Class methods

	def self.now_playing(page: 1, hit_status: false)
		build_movie_list_with movie_list_source.call page: page, hit_status: hit_status
	end

	def self.now_playing_by_genre(page: 1, hit_status: false, with_genres:)
		build_movie_list_with filtered_movie_list_source.call page: page, hit_status: hit_status, with_genres: with_genres
	end

	def self.movie_list_metadata(page: 1, hit_status: false)
		OpenStruct.new movie_list_metadata_source.call page: page, hit_status: hit_status
	end

	def self.filtered_movie_list_metadata(page: 1, hit_status: false, with_genres:)
		OpenStruct.new filtered_movie_list_metadata_source.call page: page, hit_status: hit_status, with_genres: with_genres
	end

	def self.get_movie(id:)
		build_movie_with movie_fetcher.call id: id
	end

	# Instance methods

	def hit_movie?
		vote_rating >= 7 && total_votes >= 100
	end

	def vote_rating
    @vote_rating.round rescue nil
  end

  def vote_rating?
  	vote_rating.present? && vote_rating != 0 ? true : false
  end


	private

		def self.movie_list_source
			@movie_list_source ||= MovieAdapter.singleton_method(:filter_by)
		end

		def self.movie_list_source=(source)
			@movie_list_source = source
		end

		def self.movie_list_metadata_source
			@movie_list_metadata_source ||= MovieAdapter.singleton_method(:filter_metadata_by)
		end

		def self.movie_list_metadata_source=(source)
			@movie_list_metadata_source = source
		end

		def self.filtered_movie_list_source
			@filtered_movie_list_source ||= MovieAdapter.singleton_method(:filter_by)
		end

		def self.filtered_movie_list_source=(source)
			@filtered_movie_list_source = source
		end

		def self.filtered_movie_list_metadata_source
			@filtered_movie_list_metadata_source ||= MovieAdapter.singleton_method(:filter_metadata_by)
		end

		def self.filtered_movie_list_metadata_source=(source)
			@filtered_movie_list_metadata_source = source
		end

		def self.movie_fetcher
			@movie_fetcher ||= MovieAdapter.singleton_method(:get_movie)
		end

		def self.movie_fetcher=(fetcher)
			@movie_fetcher = fetcher
		end

end