Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  # Conditional root route
  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'dashboard#index', as: :unauthenticated_root
  end

  get 'dashboard/index'
  resources :users
  resources :categories, param: :slug do
    resources :subcategories, controller: 'categories', param: :slug
  end
  resources :products, param: :slug do
    resources :variant_names, only: [] do
      resources :variant_values, only: []
    end
  end
  resources :districts do
    resources :sub_districts, only: []
  end
end
