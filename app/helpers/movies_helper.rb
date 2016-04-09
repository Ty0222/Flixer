module MoviesHelper
	def format_total_gross(movie)
		if movie.flop?
			content_tag(:strong, "Flop!")
		else
			number_to_currency(movie.total_gross)
		end
	end

	def image_for(movie, options={})
		if movie.image.exists?
			if options[:type] && (options[:type] == :favorite_movie || options[:type] == :small)
				image_tag(movie.image.url(:small))
			elsif options[:type] && options[:type] == :med
				image_tag(movie.image.url(:med))
			else
				image_tag(movie.image.url(:default)})
			end 
		else
			image_tag("placeholder.png")
		end
	end

	def format_average_stars(movie)
		if movie.average_stars.nil?
			content_tag(:strong, "No reviews", class: "no-review")
		else
			movie.average_stars.round
		end 
	end

	def ratings_exist(review_rating)
		review_rating.kind_of? Integer
	end

	def classic(movie)
		if movie.classic?
			content_tag(:strong, "Classic!")
		else
			nil
		end
	end

	def themed_page_bg(movie)
		if movie.image
			image_tag(movie.image.original_filename, class: "show-page-bg")
		end
	end
end
