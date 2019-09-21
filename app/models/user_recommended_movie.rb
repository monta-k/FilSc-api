class UserRecommendedMovie < ApplicationRecord
  belongs_to :user
  belongs_to :tmdb_movie
end
