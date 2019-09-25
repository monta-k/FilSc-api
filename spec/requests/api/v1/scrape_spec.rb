require 'rails_helper'

describe 'ScrapeApi' do
  include_context :authenticated_user

  it 'Filmarksのユーザー情報をスクレイピング' do
    get '/api/v1/scrape/find_user', params: { searchId: 'monta.k' }

    expect(response.status).to eq(200)
  end

  it 'クリップ映画のページ数をスクレイピング' do
    get '/api/v1/scrape/clip_movies_page', params: { userId: 'monta.k' }

    expect(response.status).to eq(200)
  end

  it 'クリップしている映画をスクレイピング' do
    get '/api/v1/scrape/clip_movies', params: { userId: 'monta.k', page: 1 }

    expect(response.status).to eq(200)
  end
end