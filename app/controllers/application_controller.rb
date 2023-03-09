class ApplicationController < ActionController::Base
  before_action :set_tenant

  private

  def set_tenant
    subdomain = request.subdomain

    subdomain.present? ? switch_tenant(subdomain) : switch_tenant
  end
end
