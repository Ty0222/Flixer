class Genre < ActiveRecord::Base
	to_param :name

	has_many :characterizations, dependent: :destroy
	has_many :movies, through: :characterizations

	validates :name, presence: true, uniqueness: true
end
