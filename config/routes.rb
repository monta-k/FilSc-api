Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resource :users
      resource :movies
      resource :popular_movies
      resources :signin, only: [:create]
      get '/scrape/find_user', to: 'scrape#find_user'
      get '/scrape/clip_movies_page', to: 'scrape#clip_movies_page'
      get '/scrape/clip_movies', to: 'scrape#clip_movies'
    end
  end
end
