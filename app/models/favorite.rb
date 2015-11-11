class Favorite < ActiveRecord::Base
  belongs_to :movie, foreign_key: "movie_slug"
  belongs_to :user
end
