class Movie < ActiveRecord::Base
	def flop?
		total_gross.blank? || total_gross < 50000000.0
	end

	def self.released_movies
		where("released_on <= ?", Date.today).order(released_on: :desc)
	end
end
