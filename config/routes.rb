Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]

  # Conditional root route
  authenticated :admin do
    root to: 'admins#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'dashboard#index', as: :unauthenticated_root
  end

  get 'dashboard/index'
  resources :admins
  resources :categories do
    resources :subcategories, controller: 'categories'
  end
end
