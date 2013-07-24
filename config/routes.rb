QuangoAssurance::Application.routes.draw do

  resources :client_project_assignments


  resources :issue_notes


  resources :issues

  resources :deliverables

  resources :projects

  devise_for :users

  resources :pusher

  resources :dashboard, :path => '' do 
    get :project_list, :on => :collection
    get :deliverables_list, :on => :collection
    get :deliverable, :on => :collection
    get :client_list, :on => :collection
    get :project, :on => :collection
    get :client, :on => :collection
    get :qa, :on => :collection
    get :note, :on => :collection
    get :issue, :on => :collection
    put :update_issue, :on => :collection
    put :update_owner, :on => :collection
    put :update_client, :on => :collection
    put :invite_client, :on => :collection
    post :get_user, :on => :collection
    get :create_bugherd, :on => :collection
    get :bugherd_help, :on => :collection
    get :account, :on => :collection
    get :user_management, :on => :collection
    get :user, :on => :collection
    post :invite_user, :on => :collection
    put :update_user, :on => :collection
    get :feed, :on => :collection
  end

  root :to => 'Dashboard#index'
  match '/project/:id' => "Dashboard#project"
  match '/deliverable/:id' => "Dashboard#deliverable"
  match '/issue/:id' => "Dashboard#issue"
  match '/qa/:id' => "Dashboard#qa"
  match '/deliverables_list/:id' => "Dashboard#deliverables_list"
  get '/feed/:id' => "Dashboard#feed"
  match '/pusher/auth' => "Dashboard#get_user"
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
  # match ':controller(/:action(/:id))(.:format)'
end
