Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :users
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: {format: :json} do
    get "cards/commanders", to: "cards#commanders"
    get "cards/search", to: "cards#search"
    get "cards/find_by", to: "cards#find_by"
    get "cards/suggestions", to: "cards#suggestions"
    resources :decks, only: [:create, :show, :update, :index, :destroy]
    resource :users, only: [ :create, :show]
    resource :session, only: [:create, :destroy]
    resources :categories, only: [:index, :create, :show]


  end

end
