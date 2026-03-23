Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  get "/about", to: "pages#about"
end