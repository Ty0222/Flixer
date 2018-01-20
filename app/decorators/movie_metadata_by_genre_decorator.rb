class MovieMetadataByGenreDecorator < Decorator
  include MovieMetadata::Pagination

  def self.decorate(object, genre_ids: 1)
    @@genre_ids = genre_ids
    super(object)
  end
  
  def movie_list_url(page: 1, hit_status: false, context:)
    context.filtered_movies_by_genre_url(genre_ids: genre_ids, page: page, hit_status: hit_status)
  end

  private

    def genre_ids
      @@genre_ids
    end

end