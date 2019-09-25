require 'rails_helper'

describe 'MovieApi' do
  include_context :authenticated_user
  let!(:movies) { create_list(:movie, 10, user: auth_user) }

  it 'ユーザーのクリップしている映画一覧を取得' do
    get '/api/v1/movies'
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(10)
  end

  it 'クリップしている映画を追加' do
    post '/api/v1/movies', params: { movies: [{ title: 'タイトル', length: 100, score: '3.0', image: 'image.png', link: 'link' }] }
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(11)
  end

  it 'クリップしている映画を削除' do
    expect { delete '/api/v1/movies' }.to change(Movie, :count).by(-10)

    expect(response.status).to eq(204)
  end
end
