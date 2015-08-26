class Movie < ActiveRecord::Base
	has_many :reviews, dependent: :destroy

	validates :title, :released_on, :duration, presence: true
	validates :description, length: { minimum: 25 }
	validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
	validates :image_file_name, allow_blank: true, format: {
			with:	/\w+\.(png|jpg|gif)\z/i,
			message: "must reference a PNG, JPG, or GIF image"
		}
	RATINGS = %w[G PG PG-13 R NC-17]
	validates :rating, inclusion: { in: RATINGS }
	
	def flop?
		total_gross.blank? || total_gross < 50000000.0
	end

	def self.released_movies
		where("released_on <= ?", Time.now).order(released_on: :desc)
	end
end
