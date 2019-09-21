class TmdbMovie < ApplicationRecord
  has_many :user, through: :user_recommended_movies
  has_many :user_recommended_movies
end
