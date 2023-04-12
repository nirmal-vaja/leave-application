class Organization < ApplicationRecord
  
  scope :accepted, ->{ where("status==accepted") }
  
  enum :status, %i(pending accepted rejected)
  
  after_create :create_tenant
  after_create :create_doorkeeper_application

  def admin
    if Apartment::Tenant.current == subdomain
      User.has_one_admin.first
    else
      Apartment::Tenant.switch!(subdomain)
      User.has_one_admin.first
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def create_doorkeeper_application
    current_tenant = Apartment::Tenant.current
    Apartment::Tenant.switch!(subdomain)
    if Doorkeeper::Application.count == 0
      Doorkeeper::Application.create(name:"React client for #{name}", redirect_uri: "", scopes: "", confidential: false)
    else
      Doorkeeper::Application.first
    end
    Apartment::Tenant.switch!(current_tenant)
  end
end
