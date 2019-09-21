class User < ApplicationRecord
  has_many :movies
  has_many :recommended_movies, class_name: "TmdbMovie", through: :user_recommended_movies
  has_many :user_recommended_movies
end
