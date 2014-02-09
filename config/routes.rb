Letsdosomething::Application.routes.draw do
  get "complaints/index"

  devise_for :users

  root  to: "welcome#index"
  get   "welcome/index"
end
