class Organization < ApplicationRecord

  enum :status, %i(pending accepted rejected)
  
  after_update :create_tenant

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
    case status
    when "accepted"
      Apartment::Tenant.create(subdomain)
    when "rejected"
      Apartment::Tenant.drop(subdomain)
    end
  end
end
