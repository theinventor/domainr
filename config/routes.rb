Auth::Application.routes.draw do

  get "import/select"
  match "import/godaddy/:login" => "import#godaddy", :via => :post
  match "import/domainsite/" => "import#domainsite", :via => :post

  resources :domains

  #making a little update route to manually check and return
  match "/update_now/:id", to: "domains#update_domain"

  root to: "sessions#new"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  resources :identities

end
