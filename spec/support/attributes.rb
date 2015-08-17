
def movie_attributes(overrides = {})
	{
	  title: "Iron Man 2",
 	  rating: "PG-13",
  	  total_gross: 623933331.0,
  	  description: "Six months after the events of Iron Man, Tony Stark is resisting calls by the United States government to hand over the Iron Man technology while also combating his declining health from the arc reactor in his chest. Meanwhile, rogue Russian scientist Ivan Vanko has developed the same technology in order to pursue a vendetta against the Stark family, in the process joining forces with Stark's business rival, Justin Hammer.",
  	  released_on: "May 7th, 2010"
	}.merge(overrides)
end