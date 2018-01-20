class MovieDecorator < Decorator

  def title(context)
    format_title(__getobj__.title, context)
  end

  def release_date
    format_release_date
  end

  def time_since_release_date(context)
    format_time_since_release_date(context)
  end

  def star_rating(context)
    return calculate_number_of_stars(context) if vote_rating?
    no_vote_rating(context)
  end

  def poster_image(context)
    context.image_tag(poster_url, class: "movie-billboard__poster-image")
  end

  def revenue(context)
    format_revenue(__getobj__.revenue, context)
  end

  def duration
    format_duration(super)
  end

  def background_image(context)
    context.image_tag(background_poster_url, class: "background-poster") +
     context.content_tag(:div, "", class: "background-poster is-cover")
  end

  def hit_status(context)
    context.content_tag(:p, "HIT", class: "is-hit-movie") if hit_movie?
  end
  

  private

    def format_title(title, context)
      return smaller_title(title, context) if title_too_long?(title)
      default_for(title)
    end

    def smaller_title(title, context)
      context.content_tag(:p, title, style: "font-size:16.5px")
    end

    def title_too_long?(title)
      title.length >= 25
    rescue
      nil
    end

    def format_release_date
      "#{Date.parse(released_on).to_s(:release_date)}"
    rescue
      "N/A"
    end

    def format_time_since_release_date(context)
      "(#{context.time_ago_in_words(released_on)} ago)"
    rescue
      "N/A"
    end

    def format_revenue(revenue, context)
      return "N/A" if revenue == 0
      convert_to_currency(revenue, context)
    end

    def convert_to_currency(revenue, context)
      revenue < 1000000 ? context.number_to_currency(revenue) : context.number_to_human(revenue)
    end

    def format_duration(duration)
      return "N/A" if duration == 0
      "#{duration} minutes"
    end

    def calculate_number_of_stars(context, total_stars = 0)
      total_stars += 1
      unless total_stars > vote_rating
        context.image_tag("rating_icon.png", alt: "*", class: "is-star-rating") + (calculate_number_of_stars(context, total_stars) || "")
      end
    end

    def no_vote_rating(context)
      context.content_tag(:div, "No rating", class: "is-without-rating")
    end

    def poster_url
      poster_base_with(image, image_dimension: "w600_and_h900")
    rescue
      "poster-placeholder.png"
    end

    def background_poster_url
      poster_base_with(background_poster, image_dimension: "w1066_and_h600")
    rescue
      "secondary_bg.png"
    end

    def poster_base_with(poster_path, image_dimension:)
      "https://image.tmdb.org/t/p/#{image_dimension}_bestv2" + poster_path
    end

    def default_for(attribute, context = nil)
      attribute || "N/A"
    end

end