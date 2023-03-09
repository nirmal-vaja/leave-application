# frozen_string_liberal: true

namespace :api do
  scope :users, module: :users do
    post '/', to: 'registrations#create', as: :user_registration
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications 
    end
  end
end