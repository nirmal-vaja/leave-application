class Organization < ApplicationRecord
  
  scope :accepted, ->{ where("status==accepted") }
  
  enum :status, %i(pending accepted rejected)
  
  after_create :create_tenant

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
end
