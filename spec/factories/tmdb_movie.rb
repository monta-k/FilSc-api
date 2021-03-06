FactoryBot.define do
  factory :tmdb_movie do
    sequence(:id) { |n| n }
    sequence(:title) { |n| "MOVIE_TITLE#{n}" }
    image { 'image.png' }
    homepage { 'homepage' }
  end
end
