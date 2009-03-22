ActionController::Routing::Routes.draw do |map|
  # users
  map.resources :profiles, :has_many => :friends, :has_one => :avatar
  map.resource  :account, :controller => "users"
  map.resource  :user_session
  map.resources :password_resets
  
  map.signup    'signup', :controller => 'users', :action => 'new'
  
  map.with_options :controller => 'user_sessions' do |page|  
    page.logout 'logout', :action => 'destroy'
    page.login  'login', :action => 'new'
  end
  
  map.with_options :path_prefix => 'account' do |page|    
    page.settings  'settings', :controller => 'profiles', :action => 'edit'
    page.password  'password', :controller => 'users', :action => 'edit'
    page.avatar    'avatar', :controller => 'avatars', :action => 'edit'
  end
  
  map.user_profile ':login', :controller => 'profiles', :action => 'show'
  
  # default route
  map.root :controller => "users", :action => "index"
  
  # defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
