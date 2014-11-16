Rails.application.routes.draw do
  root to: "home#index"

  resource :proxy, only: :create
end
