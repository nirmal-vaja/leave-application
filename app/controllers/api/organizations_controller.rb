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
  end

  def show

  end

  def update

  end
  
  def destroy

  end

  private

  def find_organization
    @organization = Organization.find_by_id(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :established_year, :address, :support_email, :contact_number, :type, :city, :state, :country, :description, :website_url, :subdomain
    )
  end
end