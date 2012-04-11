Quasi::Application.routes.draw do
  scope "(:locale)", :locale => /es|eu|fr|en/ do
    resources :followings
    resources :communications
    resources :comments
    resources :users
    resources :events
    resource :user_sessions
    resources :translations
    resources :password_resets
    resources :alarms
    resources :microposts
    
    get "log_in" => "user_sessions#new", :as => "log_in"
    get "log_out" => "user_sessions#destroy", :as => "log_out"  
    get "sign_up" => "users#new", :as => "sign_up"

    get "add_reminder" => "reminder#add", :as => "add_reminder"
    post "del_reminder" => "reminder#delete", :as => "del_reminder"
    get "user_reminders" => "users#reminders", :as => "rem"
    get "resubmit_event" => "events#resubmit", :as => "resubmit_event"

    get "account" => "users#microposts", :as => "account"
    
    match 'events/category/:category' => 'events#category', :as => :category
    match 'users/events_created/:user' => "users#events", :as => "ev_created"
    get "change_locale" => "application#change_locale", :as => "change_locale"
    get "commit_translation" => "translations#commit", :as => "commit_translation"
    get "account_locked" => "users#account_locked", :as => "account_locked"
    get "edit_password_reset" => "password_resets#edit", :as => "edit_password_reset"
    #match 'users/alarms' => "alarms#index", :as => "user_alarms"
    #match 'user/alarms/:alarm' => "users#alarms", :as => :alarms
    get 'alarm_switch' => "alarms#switch", :as => "alarm_switch"
    get 'cancel_event' => "events#cancel", :as => "cancel_event"
    
  end
 
  # Google verify.
  match '/google639a0342a2f63a68.html', 
        :to => proc { |env| [200, {}, ["google-site-verification: google639a0342a2f63a68.html"]] }
  
        
  match '/?locale=es' => 'events#index'
  match '/?locale=eu' => 'events#index'
  match '/?locale=fr' => 'events#index'
  match '/?locale=en' => 'events#index'
  
  root :to => "events#index"
  
  namespace :admin do |admin|
    resource :user_sessions
    resources :categories
    resources :events
    resources :translations
    get "log_in" => "user_sessions#new", :as => "log_in"
    get "log_out" => "user_sessions#destroy", :as => "log_out"
    resources :users
    root :to => "user_sessions#new"
    resources :comments
    get "ban_comment" => "comments#ban_comment", :as => "ban_comment"
    get "approve_event" =>"events#approved", :as=>"approve_event"
  end
  
  
  
#temp
  get "locations" => "events#locations", :as => "locations"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
