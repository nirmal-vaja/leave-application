module ApplicationHelper
  def switch_tenant(subdomain="public")
    Apartment::Tenant.switch!(subdomain)
  end

  def current_tenant
    Apartment::Tenant.current
  end
end
