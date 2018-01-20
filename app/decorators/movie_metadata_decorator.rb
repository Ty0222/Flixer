class MovieMetadataDecorator < Decorator
  include MovieMetadata::Pagination
  
  def movie_list_url(page: 1, hit_status: false, context:)
    context.movies_url(page: page, hit_status: hit_status)
  end

end