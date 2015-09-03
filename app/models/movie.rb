class Movie < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	has_attached_file :image

	validates :title, :released_on, :duration, presence: true
	validates :description, length: { minimum: 25 }
	validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
	validates_attachment :image, :content_type => {
			:content_type => ['image/jpeg', 'image/png'] },
			:size => { :less_than => 1.megabyte }
	RATINGS = %w[G PG PG-13 R NC-17]
	validates :rating, inclusion: { in: RATINGS }
	
	def flop?
		if total_gross.blank? || total_gross < 50000000.0 && reviews.size < 51 && reviews.average(:stars).to_i.round < 4
			true
		else
			false
		end
	end

	def average_stars
		reviews.average(:stars)
	end

	def self.released_movies
		where("released_on <= ?", Time.now).order(released_on: :desc)
	end

	def classic?
		reviews.size > 50 && reviews.average(:stars).to_i.round >= 4		
	end
end
