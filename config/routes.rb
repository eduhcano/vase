ActionController::Routing::Routes.draw do |map|
  # users
  map.resources :profiles, :has_many => :friends, :has_one => :avatar
  map.resource  :account, :controller => "users"
  map.resource  :user_session
  map.resources :password_resets
  
  map.signup    'signup', :controller => 'users', :action => 'new'
  map.logout    'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login     'login', :controller => 'user_sessions', :action => 'new'
  map.settings  'settings', :controller => 'profiles', :action => 'edit'
  map.user_profile ':login', :controller => 'profiles', :action => 'show'
  
  # default route
  map.root :controller => "users", :action => "index"
  
  # defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
