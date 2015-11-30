Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :users
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: {format: :json} do
    get "cards/commanders", to: "cards#commanders"
    resource :users, only: [ :create, :show]
    resource :session, only: [:create, :destroy]


  end

end
