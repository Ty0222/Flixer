class Movie < ActiveRecord::Base
	self.primary_key = "slug"

	has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy, foreign_key: "movie_slug"
	has_many :favorites, dependent: :destroy, foreign_key: "movie_slug"
	has_many :fans, through: :favorites, source: :user
	has_many :characterizations, dependent: :destroy, foreign_key: "movie_slug"
	has_many :genres, through: :characterizations
	has_attached_file :image, styles: {
		default: "214x320>", small: "86x86>"
	}
	
	before_validation :generate_slug

	validates_attachment :image, :content_type => {
			:content_type => ['image/jpeg', 'image/png'] },
			:size => { :less_than => 1.megabyte }
	validates :title, presence: true, uniqueness: true
	validates :released_on, :duration, presence: true
	validates :description, length: { minimum: 25 }
	validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
	RATINGS = %w[G PG PG-13 R NC-17]
	validates :rating, inclusion: { in: RATINGS }
	validates :slug, uniqueness: true

	scope :all_from_genre, ->(genre) { joins(:genres).where("genres.name = ?", "#{genre.name}") }
	scope :released_movies, -> { where("released_on <= ?", Time.now).order(released_on: :desc) }
	scope :rated, ->(rating) { released_movies.where("rating = ?", rating) }
	scope :upcoming, -> { where("released_on >= ?", Time.now) }
	scope :recent, -> (limit=3) { released_movies.limit(limit) }
	scope :flops, -> { released_movies.where("total_gross < ?", 50000000.0) }
	scope :hits, -> { released_movies.where("total_gross >= ?", 400000000.0) }


	def self.to_param
		slug
	end

	def generate_slug
		self.slug ||= title.parameterize if title		
	end

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

	def classic?
		reviews.size > 50 && reviews.average(:stars).to_i.round >= 4		
	end

end
