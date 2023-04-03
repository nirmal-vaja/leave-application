module Api
  module V1
    class OrganizationsController < ApiController
      skip_before_action :doorkeeper_authorize!
      before_action :find_organization, only: [:update_status]      

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
          current = Apartment::Tenant.current
          Apartment::Tenant.switch!(@organization.subdomain)
          user = User.new(
            first_name: @organization.name,
            last_name: "'s Admin",
            date_of_joining: Date.today,
            phone_number: "9898989898",
            email: params[:admin_email],
            password: params[:admin_password],
            admin: true
          )
          if user.save
            Apartment::Tenant.switch!(current)
            render json: {
              message: "Organization has been created.",
              status: :created,
              data: {
                organization: @organization
              }
            }
          else
            render json: {
              message: user.errors.full_messages.join(' '),
              status: :unprocessable_entity
            }
          end
        else
          render json: {
            message: @organization.errors.full_messages.join(' '),
            status: :unprocessable_entity
          }
        end
      end

      def update_status
        if @organization.update(organization_params)
          render json: {
            data: {
              organization: @organization
            }, status: :ok
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
        params.require(:organization).permit(:name, :support_email, :contact_number, :city, :state, :country, :subdomain, :status)
      end
    end
  end
end
