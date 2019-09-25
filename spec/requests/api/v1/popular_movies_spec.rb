require 'rails_helper'

describe 'ScrapeApi' do
  let!(:movies) { create_list(:tmdb_movie, 20) }
  let!(:popular_movies) { create_list(:popular_movie, 10) }

  it '人気の映画を取得' do
    get '/api/v1/popular_movies'
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(10)
  end
end
