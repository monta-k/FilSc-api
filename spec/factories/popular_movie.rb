FactoryBot.define do
  factory :popular_movie do
    sequence(:tmdb_movie_id) { |n| n }
  end
end