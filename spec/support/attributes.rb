
def movie_attributes(overrides = {})
	{
	  title: "Iron Man 2",
 	  rating: "PG-13",
    total_gross: 623933331.0,
 	  description: "Six months after the events of Iron Man, Tony Stark is resisting calls by the United States government to hand over the Iron Man technology while also combating his declining health from the arc reactor in his chest. Meanwhile, rogue Russian scientist Ivan Vanko has developed the same technology in order to pursue a vendetta against the Stark family, in the process joining forces with Stark's business rival, Justin Hammer.",
 	  released_on: "2010-05-07",
 	  cast: "Ryan Reynolds",
 	  director: "Tim Miller",
 	  duration: "123 min",
 	  image: open("#{Rails.root}/app/assets/images/ironman2.jpg"),
	}.merge(overrides)
end

def review_attributes(overrides = {})
	{
		stars: 3,
		comment: "I laughed, I cried, I spilled my popcorn!",
		location: "Middletown, New Jersey"
	}.merge(overrides)

end

def user_attributes(overrides = {})
	{
		name: "Ty Kelly",
		username: "Ty0222",
		email: "kellytyquan@example.com",
		password: "secret",
		password_confirmation: "secret",
		admin: true
	}.merge(overrides)
end