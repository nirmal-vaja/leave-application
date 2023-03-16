module Api
  module V1
    class OrganizationsController < ApiController
      def index
        @organizations = Organization.all
        render json: {
          data: {
            organizations: @organizations
          },
          status: :ok
        }
      end
    
      def create
        @organization = Organization.new(organization_params)
    
        if @organization.save
          current = current_tenant
          switch_tenant(@organization.subdomain)
          user = User.new(
            first_name: @organization.name,
            last_name: "'s Admin",
            date_of_joining: @organization.established_year,
            phone_number: "9898989898",
            email: params[:admin_email],
            password: params[:admin_password],
            admin: true
          )
          user.save
          switch_tenant(current)
          render json: {
            message: "Organization has been created.",
            status: :created,
            data: {
              organization: @organization
            }
          }
        else
          render json: {
            message: @organization.errors.full_messages.join(' '),
            status: :unprocessable_entity
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
  end
end
