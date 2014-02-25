Letsdosomething::Application.routes.draw do
  resources :complaints
  match 'complaint/:id/advocated_by/:user_id', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#advocated_by', 
      :via => [ :post ] }

  devise_for :users
  root  to: "welcome#index"
  get   "welcome/index"
end
