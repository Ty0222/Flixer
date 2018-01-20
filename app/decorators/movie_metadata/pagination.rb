module MovieMetadata
  module Pagination

    def previous_page_link(context)
      context.link_to "Prev <", movie_list_url(page: page - 1, context: context),
       id: "pg-#{page - 1}", class: "movie-page-metadata__page-link"
    end

    def next_page_link(context)
      context.link_to "> Next", movie_list_url(page: page + 1, context: context),
       id: "pg-#{page + 1}", class: "movie-page-metadata__page-link"
    end

    def pagination_links(context)
      return calculate_num_of_pages_needed(context)
    end

    private

      def calculate_num_of_pages_needed(context, page_number = first_page_of_ten, counter = 1)
        unless no_pages_left?(page_number) || counter > 10
          page_link(context, page_number) + (calculate_num_of_pages_needed(context, page_number + 1, counter + 1) || "")
        end
      end

      def page_link(context, page_number)
        return disabled_link(context, page_number) if page == page_number

        context.link_to("#{page_number}", movie_list_url(page: page_number, context: context), 
          id: "pg-#{page_number}", class: "movie-page-metadata__page-link")
      end

      def disabled_link(context, page_number)
        context.content_tag(:span, "#{page_number}", id: "pg-#{page_number}", class: "movie-page-metadata__page-link is-current")
      end

      def no_pages_left?(page_number)
        page_number > total_pages
      end

      def first_page_of_ten
        current_page_is_multiple_of_ten ? nine_pages_from_current_page : most_recent_multiple_of_ten + 1
      end

      def current_page_is_multiple_of_ten
        page % 10 == 0
      end

      def nine_pages_from_current_page
        page - 9
      end

      def most_recent_multiple_of_ten
        page - page % 10
      end
      
  end

end