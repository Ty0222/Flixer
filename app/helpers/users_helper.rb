module UsersHelper

	def profile_image_for(user, options={})
		size = options[:size] || 80
		gravatar_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
		if size < 80
			image_tag(gravatar_url, alt: user.name, class: "review-profile-image")
		else
			image_tag(gravatar_url, alt: user.name, class: "user-profile-image")
		end
	end
end
