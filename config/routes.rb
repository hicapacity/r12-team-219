Nexus::Application.routes.draw do
  devise_for :users

  resources :home, :only => :index
  get 'pages' => 'pages#index'
  get 'pages/*url_path' => 'pages#show'
  post 'pages/*url_path' => 'pages#create'

  root :to => 'home#index'

  match '/token' => 'home#token', :as => :token
  authenticated :user do
    root :to => 'home#index'
  end
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
