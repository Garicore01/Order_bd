Rails.application.routes.draw do
  
  root "index#index"
  get "/index", to:"index#index", as: :index
  post "/index", to:"index#delete"

  get "/login", to:"autenticacion/login#new", as: :login
  get "/register", to: "autenticacion/register#new"

  get "/logout", to:"autenticacion/logout#logout", as: :logout

  get "/newpedido", to: "formularionuevopedido#new", as: :formularionuevopedido
  post "/newpedido", to: "formularionuevopedido#newPedido"
  
  get "/modifypedido/:id", to: "formulariomodificarpedido#new", as: :modifypedido
  patch "/modifypedido/:id", to: "formulariomodificarpedido#modificar"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  


  namespace :autenticacion, path: '', as: '' do
    resources :login, only: [:new, :create]
    resources :register, only: [:new, :create]
    resources :logout, only: [:logout]
  end
end
