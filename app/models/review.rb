class Review < ActiveRecord::Base
  belongs_to :movie, foreign_key: "movie_slug"
  belongs_to :user

  validates :comment, length: { minimum: 4 }
  STARS = [1, 2, 3, 4, 5]
  validates :stars, inclusion: {
  	in: STARS,
  	message: "must be between 1 and 5"
  }
  validates :location, allow_blank: true, format: { 
  	with: /\w(, )(A|C|D|F|G|H|I|K|L|M|N|O|P|R|S|T|U|V|W)\w(\s(H|J|M|Y|C|D|I|C|D|V)\w)?/
  }
end
