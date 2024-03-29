class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin ec2-65-1-3-48.ap-south-1.compute }
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  use_doorkeeper
  constraints SubdomainConstraint do
    devise_for :users
    resources :leaves, only: [:index, :show, :create, :update, :destroy]
    resources :holidays, only: [:index, :show, :create, :update, :destroy]
  end

  root "home#index"

  draw :api
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
