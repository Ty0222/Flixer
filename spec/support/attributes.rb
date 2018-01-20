def movie_list_data(overrides = {})
	{
		id: 1,
	  title: "Iron Man 2",
 	  release_date: "2010-05-07",
 	  poster_path: "/iron_man2.jpg",
 	  vote_average: 7.3,
 	  vote_count: 100,
 	  overview: "This is an overview."
	}.merge(overrides)
end

def movie_list_metadata(overrides = {})
	{
		page: 1,
		total_pages: 10
	}.merge(overrides)
end

def movie_data(overrides = {})
	{
		revenue: 1056389228,
		runtime: 152,
		backdrop_path: "/iron_man2.jpg",
		genres: [{id: 1, name: "Action"}, {id: 2, name: "Adventure"}]
	}.merge(movie_list_data).merge(overrides)
end

def genre_list_data(overrides = {})
	{
		id: 1,
		name: "Action"
	}.merge(overrides)
end