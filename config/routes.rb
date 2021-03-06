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

  map.with_options :path_prefix => 'settings', :action => 'edit' do |page|    
    page.personal       'personal', :controller => 'profiles', :action => 'personal'
    page.my_account     'account', :controller => 'users'
    page.preferences    'preferences', :controller => 'profiles', :action => 'preferences'    
  end
  
  map.with_options :controller => 'friends', :path_prefix => 'friends' do |page|
    page.confirm 'confirm/:login', :action => 'create'
    page.break   'remove/:login', :action => 'destroy'
  end

  map.user_profile ':login', :controller => 'profiles', :action => 'show'
  
  # default route
  map.root :controller => "users", :action => "index"
  
  # defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
