Letsdosomething::Application.routes.draw do
  resources :posts


  resources :complaints

  devise_for :users

  root  to: "welcome#index"
  get   "welcome/index"
end
