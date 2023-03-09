class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin }
    Rails.logger request.subdomain
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  constraints SubdomainConstraint do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_application  
    end

    namespace :api do
      resources :users, only: %i[create]
    end
    # devise_for :users
  end
  
  draw :api
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
