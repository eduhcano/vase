ActionController::Routing::Routes.draw do |map|
  # users
  map.resources :profiles
  map.resource  :account, :controller => "users"
  map.resource  :user_session
  map.resources :password_resets
   
  # default route
  map.root :controller => "users", :action => "index"
  
  # defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
