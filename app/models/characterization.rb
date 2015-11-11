class Characterization < ActiveRecord::Base
  belongs_to :movie, foreign_key: "movie_slug"
  belongs_to :genre
end
