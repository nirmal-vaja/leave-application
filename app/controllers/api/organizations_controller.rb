class Api::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    render json: {
      data: {
        organizations: @organizations
      }
    }
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      current = current_tenant
      switch_tenant(@organization.subdomain)
      user = User.new(
        first_name: "",
        last_name: "",
        date_of_joining: @organization.established_year,
        phone_number: "",
        email: params[:admin_email],
        password: params[:admin_password],
        admin: true
      )
      user.save
      switch_tenant(current)
      render json: {
        message: "Organization has been created.",
        status: true,
        data: {
          organization: @organization
        }
      }
    else
      render json: {
        message: @organization.errors.full_messages.join(' '),
        status: false
      }
    end
  end

  private

  def find_organization
    @organization = Organization.find_by_id(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :established_year, :address, :support_email, :contact_number, :type, :city, :state, :country, :description, :website_url, :subdomain)
  end
end