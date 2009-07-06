ActionController::Routing::Routes.draw do |map|
  ID_SEPARATOR = /[^#{::ActionController::Routing::SEPARATORS.join}]+/

  map.root :controller=>"posts"
  map.resources :posts do |posts|
    posts.resources :comments, :requirements=>{:model_name=>'Post'}
  end
  map.asset_download "asset/download/:id", :controller=>"assets", :action=>"download", :requirements=>{:id=>ID_SEPARATOR}
#  map.upload_file_save "posts/upload_file_save",:controller=>"posts",:action=>"upload_file_save"
  map.resource :user_session
  map.resources :users
  map.resources :assets
#  map.resources :comments
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
