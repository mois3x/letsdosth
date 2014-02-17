Letsdosomething::Application.routes.draw do
  resources :complaints

  devise_for :users

  root  to: "welcome#index"
  get   "welcome/index"
end
