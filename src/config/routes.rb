Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/sign_out', to: 'devise/sessions#destroy'
    get 'users/:id/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdrawal', to: 'users#withdrawal', as: 'withdrawal'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events do
    resource :bookmarks, only: [:create, :destroy]
    collection do
      get 'history'
      get 'bookmarks'
    end
  end
  root to: 'events#index'
  get 'accounts', to: 'accounts#show'
  get 'accounts/profile', to: 'accounts#profile'
  get 'accounts/user/:id', to: 'accounts#user', as: 'user_account'
  get 'accounts/profile/edit', to: 'accounts#profile_edit'
  patch '/accounts/profile/update', to: 'accounts#profile_update'
end
