module ApplicationHelper
	def page_title
		if content_for?(:title)
			 content_tag(:title, "Flixer - #{content_for(:title)}")
		else
			content_tag(:title, "Flixer")
		end
	end

  def get_movies_url(movies_metadata)
    return movies_url(hit_status: false) unless movies_metadata
    movies_metadata.movie_list_url(page: movies_metadata.page, hit_status: false, context: self)
  end

  def get_hit_movies_url(movies_metadata)
    return movies_url(hit_status: true) unless movies_metadata
    movies_metadata.movie_list_url(page: movies_metadata.page, hit_status: true, context: self)
  end
end
