module ApplicationHelper
	def page_title
		if content_for?(:title)
			 content_tag(:title, "Flixer - #{content_for(:title)}")
		else
			content_tag(:title, "Flixer")
		end
	end
end
