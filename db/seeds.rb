# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!({
	name: "Ty Kelly",
	username: "Admin0222",
	email: "kellytyquan@realitiy.com",
	password: "secret",
	password_confirmation: "secret",
	admin: true
	})

Genre.create!([{ name: "Action" }, { name: "Comedy" }, { name: "Drama" }, { name: "Sci-Fi" }])
Genre.create!([{ name: "Romance" }, { name: "Thriller" }, { name: "Fantasy" }])
Genre.create!([{ name: "Documentary" }, { name: "Adventure" }, { name: "Animation" }])

Movie.create!([
	{
		title: "The Amazing Spider-Man",
		rating: "PG-13",
		total_gross: 757930663.0,
		description:
		%{
			Peter Parker, a teenager from New York City who becomes Spider-Man 
			after being bitten by a genetically altered spider. Parker must stop 
			Dr. Curt Connors as a mutated lizard from spreading a mutation serum 
			to the city's human population.
			}.squish,
		released_on: "2012-07-03",
		cast: "Andrew Garfield, Emma Stone, Rhys Ifans, Denis Leary",
		director: "Marc Webb",
		duration: "136 min"
	},
	{
		title: "Iron Man 2",
		rating: "PG-13",
		total_gross: 623933331.0,
		description:
		%{
			Six months after the events of Iron Man, Tony Stark is resisting calls 
			by the United States government to hand over the Iron Man technology 
			while also combating his declining health from the arc reactor in his 
			chest. Meanwhile, rogue Russian scientist Ivan Vanko has developed 
			the same technology in order to pursue a vendetta against the Stark 
			family, in the process joining forces with Stark's business rival, 
			Justin Hammer.
			}.squish,
		released_on: "2010-05-07",
		cast:"Robert Downey Jr., Gwyneth Paltrow , Don Cheadle, Scarlett Johansson",
		director: "Jon Favreau",
		duration: "125 min"
	},
	{
		title: "The Dark Knight",
		rating: "PG-13",
		total_gross: 1004558444.0,
		description:
		%{
			Batman raises the stakes in his war on crime. With the help of Lieutenant 
			Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle 
			the remaining criminal organizations that plague the city streets. The 
			partnership proves to be effective, but they soon find themselves prey to 
			a reign of chaos unleashed by a rising criminal mastermind known to the 
			terrified citizens of Gotham as The Joker.
			}.squish,
		released_on: "2008-07-24",
		cast: "Christian Bale, Michael Caine, Heath Ledger, Gary Oldman",
		director: "Christopher Nolan",
		duration: "152 min"
	},
	{
		title: "Free Willy 3",
		rating: "PG",
		total_gross: 153698625.0,
		description:
		%{
			When a boy learns that a beloved killer whale is to be killed by the 
			aquarium owners, the boy risks everything to free the whale.
			}.squish,
		released_on: "1993-07-16",
		cast: "Jason James Richter, August Schellenberg, Annie Corley, Vincent Berry",
		director: "Sam Pillsbury",
		duration: "86 min"
	},
	{
		title: "Catwoman",
		rating: "PG-13",
		total_gross: 40000000.0,
		description:
		%{
			Patience Phillips has a more than respectable career as a graphic designer.
			}.squish,
		released_on: "2004-07-23",
		cast: "Halle Berry, Benjamin Bratt, Lambert Wilson, Frances Conroy",
		director: "Pitof",
		duration: "104 min"
	},
	{
		title: "Superman",
		rating: "PG",
		total_gross: 300218018.0,
		description:
		%{
			Superhero disguised as a reporter, Clark Kent adopts a mild-mannered 
			disposition in Metropolis and develops a romance with Lois Lane, while 
			battling the villainous Lex Luthor.
			}.squish,
		released_on:"1978-12-15",
		cast: "Marlon Brando, Gene Hackman, Christopher Reeve, Ned Beatty",
		director: "Richard Donner",
		duration: "143 min"
	}
])