module MoviesHelper
	def format_total_gross(movie)
		if movie.flop?
			content_tag(:strong, "Flop!")
		else
			number_to_currency(movie.total_gross)
		end
	end

	def image_for(movie)
		if movie.image.exists?
			image_tag(movie.image.url)
		else
		image_tag("placeholder.png")
		end
	end

	def format_average_stars(movie)
		if movie.average_stars.nil?
			content_tag(:strong, "No reviews")
		else
			"*" * movie.average_stars.round
		end 
	end

	def classic(movie)
		if movie.classic?
			content_tag(:strong, "Classic!")
		else
			nil
		end
	end
end
