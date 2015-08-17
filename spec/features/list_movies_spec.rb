
describe "Viewing the list of movies" do
  it "shows the movies" do
    movie1 = Movie.create(title: "Iron Man 2",
  						  rating: "PG-13",
  						  total_gross: 623933331.0,
  						  description: "Six months after the events of Iron Man, Tony Stark is resisting calls by the United States government to hand over the Iron Man technology while also combating his declining health from the arc reactor in his chest. Meanwhile, rogue Russian scientist Ivan Vanko has developed the same technology in order to pursue a vendetta against the Stark family, in the process joining forces with Stark's business rival, Justin Hammer.",
  						  released_on: "2008-05-02")

	movie2 = Movie.create(title: "Superman",
						  rating: "PG",
  						  total_gross: 300218018.0,
  						  description: "Superhero disguised as a reporter, Clark Kent adopts a mild-mannered disposition in Metropolis and develops a romance with Lois Lane, while battling the villainous Lex Luthor.",
  						  released_on: "1978-12-15")

	movie3 = Movie.create(title: "The Amazing Spider-Man",
  						  rating: "PG-13",
  						  total_gross: 757930663.0,
  						  description: "Peter Parker, a teenager from New York City who becomes Spider-Man after being bitten by a genetically altered spider. Parker must stop Dr. Curt Connors as a mutated lizard from spreading a mutation serum to the city's human population.",
  						  released_on: "2002-05-03")

  	visit movies_url

  	expect(page).to have_content("3 Movies")
  	expect(page).to have_content(movie1.title)
  	expect(page).to have_content(movie2.title)
  	expect(page).to have_content(movie3.title)


  	expect(page).to have_content(movie1.rating)
  	expect(page).to have_content("$623,933,331.00")
  	expect(page).to have_content(movie1.description[0..40])
  	expect(page).to have_content("May 2nd, 2008")
  end
end