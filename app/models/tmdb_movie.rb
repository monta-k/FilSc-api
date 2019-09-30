class TmdbMovie < ApplicationRecord
  has_many :user, through: :user_recommended_movies
  has_many :user_recommended_movies, dependent: :destroy

  has_one :popular_movie, dependent: :destroy
end
