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
  resources :categories, param: :slug do
    resources :subcategories, controller: 'categories', param: :slug
  end
  resources :products do
    resources :variant_names, only: [] do
      resources :variant_values, only: []
    end
  end
end
