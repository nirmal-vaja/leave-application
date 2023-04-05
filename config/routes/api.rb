# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end
    resources :leaves, only: [:index, :show, :create, :update, :destroy] do
      member do
        put :update_status
      end
    end
    resources :holidays, only: [:index, :show, :create, :update, :destroy] 
    resources :organizations, only: [:index, :create] do
      member do
        put :update_status
      end
    end
    resources :bank_infos, only: [:create, :update]
    resources :salaries, only: [:create]
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end
  end
end