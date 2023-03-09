class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin ec2-65-1-3-48.ap-south-1.compute }
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  constraints SubdomainConstraint do
    devise_for :users
  end

  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
