FactoryBot.define do
  factory :movie do
    association :user, factory: :user
    sequence(:title) { |n| "MOVIE_TITLE#{n}" }
    length { 100 }
    score { '3.0' }
    image { 'image.png' }
    link { 'link' }
  end
end
